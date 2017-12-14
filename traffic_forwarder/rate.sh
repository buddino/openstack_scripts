#!/bin/bash
tc qdisc add dev ens3 handle 1: root htb default 11
tc class add dev ens3 parent 1: classid 1:1 htb rate 1000Mbps
tc class add dev ens3 parent 1:1 classid 1:11 htb rate 20Mbit
tc qdisc add dev ens3 parent 1:11 handle 10: netem delay 250ms
