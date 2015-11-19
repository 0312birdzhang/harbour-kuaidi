#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on 2015年6月17日

@author: 0312birdzhang
'''
from bs4 import BeautifulSoup
import urllib2

allpost=[]
def queryStatus(url):
    response = urllib2.urlopen(url)
    allhtml = response.read()
    soup = BeautifulSoup(allhtml)
    #print allhtml
    #titulo = soup.find_all("div", "one-titulo")[0].contents[0].strip() #VOL号
    kuaidis = soup.find_all("a")
    #print(kuaidis)
    for i in kuaidis:
        if i.get("data-code"):
            val=i.get("data-code")
            labels = i.contents
            label = labels[1] if len(i.contents) >1 else labels[0]
            allpost.append({"value":val,"label":label})
if __name__ == "__main__":
    queryStatus('http://m.kuaidi100.com/all/')
    print allpost
