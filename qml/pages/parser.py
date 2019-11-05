# -*- coding: utf-8 -*-
import sys,os
import requests
import json
import time
import hashlib
import random
import logging


__kuaidi_url__ = "https://m.kuaidi100.com/"
api = __kuaidi_url__ + "query?type=%s&postid=%s&temp=%s&id=1&valicode=&phone=&token=&platform=MWWW"
autoapi = __kuaidi_url__ + "autonumber/autoComNum?resultv2=1&text=%s"

logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

class KuaiDi:
    def __init__(self):
        self.cookies = {}
        self.headers = {
            "Host": "m.kuaidi100.com",
            "Referer": __kuaidi_url__,
            "X-Requested-With": "XMLHttpRequest",
            "Accept-Language": "zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2",
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Origin": "https://m.kuaidi100.com",
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101 Firefox/70.0"
        }

    def getCookie(self):
        r = requests.get(__kuaidi_url__, headers = self.headers)
        self.cookies = r.cookies
        csrftoken = self.cookies.get('csrftoken')
        wwwid = self.cookies.get('WWWID')
        self.headers['Cookie'] = 'csrftoken=%s; WWWID=%s' % (csrftoken, wwwid)

    def query(self, url):
        try:
            r = requests.get(url, headers = self.headers, cookies = self.cookies)
            the_page = r.json()
            logging.debug(the_page)
        except Exception as e:
            logging.debug(e)
            the_page = ""
        return the_page

    def getRandom(self):
        return random.random()

    def getpostinfo(self,posttype,postid):
        self.getCookie()
        self.headers["Referer"] = "%sresult.jsp?nu=%s" % (__kuaidi_url__, postid)
        return self.query(api % (posttype,str(postid),str(self.getRandom())))
    
    def queryvendor(self,postid):
        return self.query(autoapi % (str(postid)))

kuaidi = KuaiDi()
