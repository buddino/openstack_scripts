#!/bin/bash

echo "Creating security group OPEN"
openstack security group create --project demo OPEN  > /dev/null
openstack security group rule create --ingress --protocol tcp --dst-port 1:65535 OPEN  > /dev/null
openstack security group rule create --ingress --protocol udp --dst-port 1:65535 OPEN  > /dev/null
openstack security group rule create --ingress --protocol icmp OPEN  > /dev/null

echo "Creating flavour(s)"
openstack flavor create --id uhalf --ram 512 --disk 5 ubuntuX0_5  > /dev/null
openstack flavor create --id u1 --ram 1024 --disk 5 ubuntuX1  > /dev/null
openstack flavor create --id u2 --vcpu 2 --ram 1024 --disk 5 ubuntuX2  > /dev/null
openstack flavor create --id u4 --vcpu 4 --ram 1024 --disk 5 ubuntuX4  > /dev/null
openstack flavor delete c1  > /dev/null
openstack flavor delete d2  > /dev/null
openstack flavor delete d3  > /dev/null
openstack flavor delete d4  > /dev/null
openstack flavor delete d1 > /dev/null
openstack flavor delete 4 > /dev/null
openstack flavor delete 3 > /dev/null
openstack flavor delete 84 > /dev/null
openstack flavor delete 42 > /dev/null
openstack flavor delete 2 > /dev/null
openstack flavor delete 1 > /dev/null
openstack flavor delete 5 > /dev/null

echo "Downloading image Ubuntu 16.04"
wget -P /tmp "http://192.168.9.130/cloud_images/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
openstack image create --disk-format qcow2 --file /tmp/ubuntu-16.04-server-cloudimg-amd64-disk1.img "Ubuntu16.04" > /dev/null
rm /tmp/ubuntu-16.04-server-cloudimg-amd64-disk1.img

echo "Creating keypair based on existing public key"
openstack keypair create --public-key public_key robexp > /dev/null