from time import sleep

from scapy.layers.inet import IP, ICMP, random, UDP, Ether, Raw
from scapy.sendrecv import sniff, sr, send, sendp
import scapy.route

print "Sniffing..."


def callback(data):
    #print data.summary()    
    ip = IP(src="10.0.0.13", dst="10.0.0.11")
    pkt = Ether() / ip / UDP(sport=1234, dport=5000) / Raw(load="CIAO")
    #print pkt.summary()
    sleep(0.1)
    sendp(pkt, realtime=True)


sniff(filter="udp and ip dst 10.0.0.13", prn=callback, store=0)

