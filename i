#!/usr/bin/env python3
 
import re
import os
import sys
 
def matches(hostname, a):
    return all([word in hostname for word in a])
 
home = os.environ['HOME']
host = sys.argv[1]
 
m = re.search('([a-zA-Z]+)(\d+)?', host)
p = list(filter(None, m.groups()))

with open(os.path.join(home, ".inventory")) as f:
    inventory = f.read().splitlines()
 
for hostname in inventory:
    if matches(hostname, p):
        os.system(f'ssh {hostname}')
        break
