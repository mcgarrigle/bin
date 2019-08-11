#!/usr/bin/env python

import sys, os.path
import random
import argparse

ROOT = os.path.dirname(os.path.realpath(__file__))

def roll():
    digits = [ str(random.randint(1, 6)) for i in range(5) ]
    return ''.join(digits)

def words():
    with open(os.path.join(ROOT, 'wordlist.txt')) as f:
        text = f.read()
    items = [ tuple(s.split()) for s in text.splitlines() ]
    index = dict(items)
    return index

parser = argparse.ArgumentParser()
parser.add_argument("-w", "--windows", help="Make complient with typical Windows policy", action="store_true")
args = parser.parse_args()

index = words()
words = [ (index[roll()], i) for i in range(4) ]

if args.windows:
    phrase = [ w[0].capitalize() + str(w[1]) for w in words ]
    phrase = '.'.join(phrase)
else:
    phrase = [ w[0] for w in words ]
    phrase = ' '.join(phrase)

print(phrase)
