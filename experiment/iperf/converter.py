#!/usr/bin/python
import json
import sys


def mean(data):
    n = len(data)
    if n < 1:
        raise ValueError('mean requires at least one data point')
    return sum(data) / n  # in Python 2 use sum(data)/float(n)


def _ss(data):
    c = mean(data)
    ss = sum((x - c) ** 2 for x in data)
    return ss


def stddev(data, ddof=0):
    n = len(data)
    if n < 2:
        raise ValueError('variance requires at least two data points')
    ss = _ss(data)
    pvar = ss / (n - ddof)
    return pvar ** 0.5


def munit(bytes):
    r = float(bytes)
    r = r / (1024 * 1024)
    r = round(r, 2)
    return str(r) + ' Mbits/s'


j = json.load(sys.stdin)
values = []
for x in j['intervals']:
    values.append(x['sum']['bits_per_second'])
print "Sending traffic to: "+j['start']['connecting_to']['host']
print "-----------"
print "MEAN: " + munit(mean(values))
print "STD: " + munit(stddev(values))
print "-----------"
#print "VALUES:"
#print map(lambda v: munit(v), values)

