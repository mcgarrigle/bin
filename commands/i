#!/usr/bin/env python3
 
import re
import os
import sys
import argparse
 
def matches(hostname, a):
    return all([word in hostname for word in a])

home = os.environ['HOME']
 
parser = argparse.ArgumentParser()
parser.add_argument("-s", "--search", help="search and print matches", action="store_true")
parser.add_argument("pattern", nargs="?", default="")
args = parser.parse_args()

with open(os.path.join(home, ".inventory")) as f:
    inventory = f.read().splitlines()

if args.pattern == "":
    for hostname in inventory:
        print(hostname)
    exit(0)

match = re.search('([a-zA-Z\-]+)(\d+)?', args.pattern)
parts = list(filter(None, match.groups()))

for hostname in inventory:
    if matches(hostname, parts):
        if args.search:
            print(hostname)
        else:
            os.system(f'ssh {hostname}')
            break
