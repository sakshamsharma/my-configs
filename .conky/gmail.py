#! /usr/bin/env python

import urllib.request
from xml.etree import ElementTree as etree

auth_handler = urllib.request.HTTPBasicAuthHandler()
auth_handler.add_password(realm='mail.google.com',
                          uri='https://mail.google.com/',
                          user= 'saksham0808',
                          passwd= 'passwordisnotstoredincleartext')
opener = urllib.request.build_opener(auth_handler)
urllib.request.install_opener(opener)

gmail = 'https://mail.google.com/gmail/feed/atom'
NS = '{http://purl.org/atom/ns#}'
with urllib.request.urlopen(gmail) as source:
    tree = etree.parse(source)
fullcount = tree.find(NS + 'fullcount').text
print('Gmail: ' + fullcount + ' unread')
