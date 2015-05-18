# Author: Dennis Lutter <lad1337@gmail.com>
# URL: https://github.com/lad1337/XDM-main-plugin-repo/
#
# This file is part of a XDM plugin.
#
# XDM plugin.
# Copyright (C) 2013  Dennis Lutter
#
# This plugin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This plugin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/.

from xdm.plugins import *
import requests
from xdm import helper
from collections import OrderedDict

class Newznab(Indexer):
    version = "0.7"
    identifier = "de.lad1337.newznab"
    config = OrderedDict([('host', 'http://nzbs2go.com'),
               ('apikey', ''),
               ('port', None),
               ('enabled', True),
               ('comment_on_download', False),
               ('retention', 900),
               ('verify_ssl_certificate', True)
               ])

    types = ['de.lad1337.nzb']

    def _baseUrl(self, host, port=None):
        if not host.startswith('http'):
            host = 'http://%s' % host
        if port:
            return "%s:%s/" % (host, port)
        if host.endswith('/'):
            return "%s" % host
        else:
            return "%s/" % host

    def _baseUrlApi(self, host, port=None):
        return "%sapi" % self._baseUrl(host, port)

    def _baseUrlRss(self, host, port=None):
        return "%srss" % self._baseUrl(host, port)

    def searchForElement(self, element):
        payload = {'apikey': self.c.apikey,
                   't': 'search',
                   'maxage': self.c.retention,
                   'cat': self._getCategory(element),
                   'o': 'json'
                   }

        downloads = []
        terms = element.getSearchTerms()
        for term in terms:
            payload['q'] = term
            r = requests.get(self._baseUrlApi(self.c.host, self.c.port), params=payload, verify=self.c.verify_ssl_certificate)
            log("Newsnab final search for term %s url %s" % (term, r.url), censor={self.c.apikey: 'apikey'})
            response = r.json()
            # log.info("jsonobj: " +jsonObject)
            if not 'item' in response["channel"]:
                log.info("No search results for %s" % term)
                continue
            items = response["channel"]["item"]
            if type(items).__name__ == 'dict': # we only have on search result
                items = [items]
            for item in items:
                # log.info("item: " + item["title"])
                title = item["title"]
                url = item["link"]
                ex_id = 0
                curSize = 0
                for curAttr in item['attr']:
                    if curAttr['@attributes']['name'] == 'size':
                        curSize = int(curAttr['@attributes']['value'])
                    if curAttr['@attributes']['name'] == 'guid':
                        ex_id = curAttr['@attributes']['value']

                log("%s found on Newznab: %s" % (element.type, title))
                d = Download()
                d.url = url
                d.name = title
                d.element = element
                d.size = curSize
                d.external_id = ex_id
                d.type = 'de.lad1337.nzb'
                downloads.append(d)

        return downloads

    def commentOnDownload(self, msg, download):
        payload = {'apikey': self.c.apikey,
                   't': 'commentadd',
                   'id': download.external_id,
                   'text': msg}
        r = requests.get(self._baseUrlApi(self.c.host, self.c.port), params=payload, verify=self.c.verify_ssl_certificate)
        log("Newsnab final comment for %s is %s on url %s" % (download.name, msg, r.url), censor={self.c.apikey: 'apikey'})
        if 'error' in r.text:
            log("Error posting the comment: %s" % r.text)
            return False
        log("Comment successful %s" % r.text)
        return True

    def _testConnection(self, host, port, apikey, verify_ssl_certificate):
        payload = {'apikey': apikey,
           't': 'search',
           'o': 'json',
           'q': 'testing_apikey'
           }
        try:
            r = requests.get(self._baseUrlApi(host, port), params=payload, verify=verify_ssl_certificate)
        except:
            log.error("Error during test connection on $s" % self)
            return (False, {}, 'Please check host!')
        if 'Incorrect user credentials' in r.text:
            return (False, {}, 'Wrong apikey!')

        return (True, {}, 'Connection made!')
    _testConnection.args = ['host', 'port', 'apikey', 'verify_ssl_certificate']

    # this is neither clean nor pretty
    # but its just a gimick and should illustrate how to use ajax calls that send data back
    def _gatherCategories(self, host, port, verify_ssl_certificate):
        payload = {'t': 'caps',
                   'o': 'json'
                   }
        r = requests.get(self._baseUrlApi(self.c.host, self.c.port), params=payload, verify=verify_ssl_certificate)

        data = {}
        for cat in r.json()['categories']['category']:
            name = cat['@attributes']['name']
            attribute_id = cat['@attributes']['id']
            for config in self.c.configs:
                if config.name in data:
                    continue
                if self.useConfigsForElementsAs.lower() in config.name.lower():
                    if config.name.lower().endswith(name.lower()):
                        data[config.name] = attribute_id

            for subcat in cat['subcat']:
                if type(subcat) is not dict:
                    continue
                if '@attributes' not in subcat:
                    continue
                if 'name' not in subcat['@attributes']:
                    continue
                subName = subcat['@attributes']['name']
                subID = subcat['@attributes']['id']
                for config in self.c.configs:
                    if config.name in data:
                        continue
                    if self.useConfigsForElementsAs.lower() in config.name.lower():
                        if config.name.lower().endswith(subName.lower()):
                            data[config.name] = subID

        dataWrapper = {'callFunction': 'newsznab_' + self.instance + '_spreadCategories',
                       'functionData': data}

        return (True, dataWrapper, 'I found %s categories' % len(data))
    _gatherCategories.args = ['host', 'port', 'verify_ssl_certificate']

    def getConfigHtml(self):
        return """<script>
                function newsznab_""" + self.instance + """_spreadCategories(data){console.log(data);
                  $.each(data, function(k,i){
                      $('#""" + helper.idSafe(self.name) + """ input[name$="'+k+'"]').val(i)
                  });
                };
                </script>
        """

    config_meta = {'plugin_desc': 'Generic Newznab indexer. Categories are there numerical id of Newznab, use "Get categories"',
                   'plugin_buttons': {'gather_gategories': {'action': _gatherCategories, 'name': 'Get categories'},
                                      'test_connection': {'action': _testConnection, 'name': 'Test connection'}},
                   }

