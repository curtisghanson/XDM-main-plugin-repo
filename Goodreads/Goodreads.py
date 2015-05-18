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
import xml.etree.ElementTree as ET

BASE_URL = 'http://www.goodreads.com'

OAuth = common.PM.getPluginByIdentifier("de.lad1337.oauth").OAuth

class Goodreads(Provider):
    config = {'api_key': ''}
    config_meta = {'plugin_desc': 'Book information from http://www.goodreads.com/. Get your own developer api key from http://www.goodreads.com/api/keys.'}
    version = "0.4"
    identifier = "de.lad1337.goodreads"
    _tag = 'goodreads'
    screenName = 'Goodreads'
    single = True
    types = ['de.lad1337.books']

    oauth = OAuth(
        "TWmiwUX5XviBfpEryYuAaQ",
        "sRTit8mnXF9CPq3GBtbkh1GmIT8lFK0esj5NAAlLek",
        base_url="http://www.goodreads.com"
    )

    def searchForElement(self, term=''):
        self.progress.reset()
        mediaType = MediaType.get(MediaType.identifier == 'de.lad1337.books')
        mtm = common.PM.getMediaTypeManager('de.lad1337.books')[0]
        fakeRoot = mtm.getFakeRoot(term)

        searchUrl = '%s/search.xml' % BASE_URL
        payload = {'q': term,
                   'key': self.c.api_key}

        r = requests.get(searchUrl, params=payload)
        log('Final Goodreads url: %s' % r.url, censor={self.c.api_key: 'apikey'})
        root = ET.fromstring(r.text.encode('utf-8'))
        for curBook in root.getiterator('work'):
            self.progress.addItem()
            self._createBook(fakeRoot, mediaType, curBook)

        return fakeRoot

    def _createBook(self, fakeRoot, mediaType, bookNode):
        bestBook = bookNode.find('best_book')
        titleNode = bestBook.find('title')
        authorNameNode = bestBook.find('author').find('name')
        idNode = bestBook.find('id')
        imageNode = bestBook.find('image_url')
        ratingNode = bookNode.find('average_rating')

        book = Element()
        book.mediaType = mediaType
        book.parent = fakeRoot
        book.type = 'Book'
        book.setField('title', titleNode.text, self.tag)
        book.setField('author', authorNameNode.text, self.tag)
        book.setField('rating', float(ratingNode.text), self.tag)
        book.setField('id', int(idNode.text), self.tag)
        book.setField('cover_image', imageNode.text, self.tag)

        book.saveTemp()

    def getElement(self, id, element=None):
        """we like tmdb ids"""
        # TODO: find a way to get the book by id
        return False





