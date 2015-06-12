#! /usr/bin/env python

import urllib.request
from xml.etree import ElementTree as etree

authdata = open('../.credentials/gmailauth')
username = authdata.readline().rstrip('\n')
password = authdata.readline().rstrip('\n')
authdata.close()

auth_handler = urllib.request.HTTPBasicAuthHandler()
auth_handler.add_password(realm='mail.google.com',
                          uri='https://mail.google.com/',
                          user= username,
                          passwd= password)
opener = urllib.request.build_opener(auth_handler)
urllib.request.install_opener(opener)

gmail = 'https://mail.google.com/gmail/feed/atom'
NS = '{http://purl.org/atom/ns#}'
with urllib.request.urlopen(gmail) as source:
    tree = etree.parse(source)
fullcount = tree.find(NS + 'fullcount').text
print('Gmail: ' + fullcount + ' unread')
