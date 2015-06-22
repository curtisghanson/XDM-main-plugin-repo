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
# pylint: disable=E1101

from xdm.plugins import *
from xdm.tasks import updateElement
import os
from operator import attrgetter

location = os.path.abspath(os.path.dirname(__file__))

string_cache = {}
def getTemplate(name):
    if name not in string_cache:
        fp = os.path.join(location, "%s.ji2" % name)
        with open (fp, "r") as template:
            string_cache[name] = template.read()
    return string_cache[name]

class Episode(object):
    title = ''
    airdate = 0
    season = 0
    number = 0
    overview = ''
    screencap_image = ''

    _orderBy = 'number'
    _orderReverse = True

    def getTemplate(self):
        return getTemplate("episode")

    def getSearchTerms(self):
        return ['%s s%02de%02d' % (self.parent.parent.title, self.parent.number, self.number)] #

    def getName(self):
        return "%se%02d %s" % (self.parent.getName(), self.number, self.title)

    def getReleaseDate(self):
        return self.airdate

    def getIdentifier(self, tag):
        return self.getField("number")

class Season(object):
    number = 0
    poster_image = ''

    _orderBy = 'number'
    _orderReverse = True

    def getTemplate(self):
        return getTemplate("season")

    def getName(self):
        return "%s s%02d" % (self.parent.title, self.number)

    def getIdentifier(self, tag):
        return self.getField("number")

class Show(object):
    title = ''
    id = ''
    airs = ''
    overview = ''
    year = 0
    poster_image = ''
    banner_image = ''
    fanart_image = ''
    show_status = ''
    country = ''
    genres = ''
    runtime = ''

    _orderBy = 'title'

    def getTemplate(self):
        return getTemplate("show")

    def getSearchTemplate(self):
        return getTemplate("show_search")

    def getName(self):
        return self.title

    def getIdentifier(self, tag):
        return self.getField('id', tag)

class TV(MediaTypeManager):
    version = "0.10"
    xdm_version = (0, 5, 17)
    single = True
    _config = {
        'enabled': True,
        'show_next_on_overview': True,
        'next_episode_info_select': 'both'}
    config_meta = {'plugin_desc': 'TV'}
    order = (Show, Season, Episode)
    download = Episode
    identifier = 'de.lad1337.tv'
    addConfig = {}
    addConfig[Downloader] = [{'type':'category', 'default': None, 'prefix': 'Category for', 'sufix': 'TV'}]
    addConfig[Indexer] = [{'type':'category', 'default': None, 'prefix': 'Category for', 'sufix': 'TV'}]
    addConfig[PostProcessor] = [{'type':'path', 'default': None, 'prefix': 'Final path for', 'sufix': 'TV'}]

    def makeReal(self, show, status):
        show.parent = self.root
        show.status = common.getStatusByID(self.c.default_new_status_select)
        show.save()
        common.Q.put(('image.download', {'id': show.id}))
        common.Q.put(
            ("element.update", {'id': show.id, "status": show.status.id})
        )
        return True

    def headInject(self):
        return self._defaultHeadInject()

    def homeStatuses(self):
        return common.getEveryStatusBut([common.TEMP])

    def getDownloadableElements(self, asList=True):
        return self.getElementsWithStatusIn([common.WANTED], asList, [self.download.__name__])

    def getUpdateableElements(self, asList=True):
        shows = Element.select().where(Element.type == 'Show',
                                       Element.parent == self.root)
        # TODO: filter out ended shows but give a grace period
        # return [s for s in shows if s.getField('show_status') != "Ended"]
        if asList:
            return list(shows)
        return shows

    def _episode_count(self, show, statuses=False):
        all_seasons = list(Element.select().where(Element.type == 'Season',
                                              Element.parent == show))
        seasons = [s for s in all_seasons if s.number]
        if statuses:
            return Element.select().where(Element.type == 'Episode',
                                          Element.parent << seasons,
                                          Element.status << statuses).count()
        else:
            return Element.select().where(Element.type == 'Episode',
                                          Element.parent << seasons).count()

    def _season_episode_count(self, season, statuses=False):
        if statuses:
            return Element.select().where(Element.type == 'Episode',
                                          Element.parent == season,
                                          Element.status << statuses).count()
        else:
            return Element.select().where(Element.type == 'Episode',
                                          Element.parent == season).count()

    def _next_episode_info_select(self):
        return {
            "title": "Episode title",
            "sxxexx": "Season and Epsiode number",
            "both": "Both"
        }

    def _get_next_episode(self, show):
        if not show.manager.c.show_next_on_overview:
            return None
        _prev_episode = None
        now = datetime.datetime.now()
        for season in sorted(show.children, key=attrgetter("number"), reverse=True):
            for episode in sorted(season.children, key=attrgetter("number"), reverse=True):
                if episode.airdate == common.FAKEDATE:
                    continue
                if now <= episode.airdate:
                    _prev_episode = episode
                elif now > episode.airdate:
                    return _prev_episode

    def _next_episode_detail_field(self, episode):
        if self.c.next_episode_info_select == "title":
            return getattr(episode, "title")
        if self.c.next_episode_info_select == "sxxexx":
            return u"s{0:02d}e{1:02d}".format(episode.number, episode.parent.number)
        if self.c.next_episode_info_select == "both":
            return u"s{0:02d}e{1:02d} - {2}".format(
                episode.number, episode.parent.number, episode.title)
