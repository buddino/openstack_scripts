#!/bin/bash

interface=ens3
ip=10.0.0.11
delay=$1

tc qdisc add dev $interface root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc qdisc add dev $interface parent 1:2 handle 20: netem delay $delay
tc filter add dev $interface parent 1:0 protocol ip u32 match ip dport 5000 0xffff flowid 1:2
