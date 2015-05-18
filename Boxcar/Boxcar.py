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

XDM_BOXCAR_PROVIDER_KEY = 'QiKnUXljz0S1Gw1zlyk8'


class Boxcar(Notifier):
    version = "0.2"
    identifier = "de.lad1337.boxcar"
    screenName = "Boxcar"
    addMediaTypeOptions = False
    config = {'email': '',
               'screenname': 'XDM'}

    def _sendTest(self, email, screenname):
        log("Testing boxcar")
        result = self._sendMessage("Test from XDM", email, screenname, None)
        if result:
            return (result, {}, 'Message send. Check your device(s)')
        else:
            return (result, {}, 'Message NOT send. Check your email')
    _sendTest.args = ['email', 'screenname']

    def _sendEnabled(self):
        log("Testing boxcar")
        self.sendMessage("You just enabled Boxcar on XDM")

    def sendMessage(self, msg, element=None):
        if not self.c.email:
            log.error("Boxcar email / user not set")
            return False
        return self._sendMessage(msg, self.c.email, self.c.screenname, element)

    def _sendMessage(self, msg, email, screenname, element):

        payload = {'notification[from_screen_name]': screenname,
                   'email': email,
                   'notification[message]': msg}

        r = requests.post('http://boxcar.io/devices/providers/%s/notifications' % XDM_BOXCAR_PROVIDER_KEY, payload)
        if r.status_code == 401:
            if self._sendSubscribtion(email):
                return self._sendMessage(msg, email, screenname, element)
            else:
                log.error('Sending notification failed, and then the subscription failed too :(')
                return False
        log("boxbar url: %s payload: %s" % (r.url, payload))
        log("boxcar code %s" % r.status_code)
        return r.status_code == requests.codes.ok

    def _sendSubscribtion(self, email):
        payload = {'email': email}

        r = requests.post('http://boxcar.io/devices/providers/%s/notifications/subscribe' % XDM_BOXCAR_PROVIDER_KEY, payload)
        return  r.status_code == requests.codes.ok

    # config_meta is at the end because otherwise the sendTest function would not be defined
    config_meta = {'enabled': {'on_enable': [_sendEnabled]},
                   'plugin_buttons': {'sendTest': {'action': _sendTest, 'name': 'Send test'}},
                   'plugin_desc': 'Simple Boxcar.io notifier. This uses the official XDM boxcar service and will subscribe you to it when the first message is send.'
                   }
