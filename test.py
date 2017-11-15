from time import sleep

from scapy.layers.inet import IP, ICMP, random, UDP, Ether, Raw
from scapy.sendrecv import sniff, sr, send, sendp
import scapy.route

print "Sniffing..."


def callback(data):
    ip = data[IP]
    ip.dst = "10.0.0.11"  # Send to B
    del ip.chksum
    pkt = Ether() / IP(dst="10.0.0.11") / UDP() 
    #pkt.show()
    sendp(pkt, realtime=True)


sniff(filter="udp and ip dst 10.0.0.13", prn=callback, store=0)

