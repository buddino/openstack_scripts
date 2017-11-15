#!/bin/sh
iptables -F
iptables -F -t nat
iptables -t nat -A PREROUTING -p udp --dport 5000 -j DNAT --to-destination 10.0.0.11:5000
#iptables -t nat -A PREROUTING -p tcp --dport 5000 -j DNAT --to-destination 10.0.0.11:5000
iptables -A FORWARD -d 10.0.0.11 -p udp --dport 5000 -j ACCEPT
#iptables -A FORWARD -d 10.0.0.11 -p tcp --dport 5000 -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE
