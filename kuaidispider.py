#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on 2015年6月17日

@author: 0312birdzhang
'''
from bs4 import BeautifulSoup
import requests
import json

allpost=[]
def queryStatus(url):
    r = requests.get(url)
    allhtml = r.text
    soup = BeautifulSoup(allhtml, features="html.parser")
    kuaidis = soup.find_all("a", attrs={'data-code': True})
    for i in kuaidis:
        val = i.get("data-code")
        labels = i.contents
        label = labels[1] if len(i.contents) >1 else labels[0]
        allpost.append({
            "value":val.strip().replace('  ','').replace('\n',''),
            "label":label.strip().replace('  ','').replace('\n','')
            })
if __name__ == "__main__":
    queryStatus('http://m.kuaidi100.com/all/')
    print(str(allpost).replace("'","\""))
