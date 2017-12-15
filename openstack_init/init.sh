#!/bin/bash
export HOST_IP=localhost
export OS_PROJECT_DOMAIN_ID=default
export OS_REGION_NAME=RegionOne
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=admin
export OS_IDENTITY_API_VERSION=3
export OS_PASSWORD=password
export OS_AUTH_TYPE=password
export OS_AUTH_URL=http://$HOST_IP/identity
export OS_USERNAME=admin
export OS_TENANT_NAME=admin
export OS_VOLUME_API_VERSION=2

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

echo "Creating archive policy for metric: processing_time"
gnocchi archive-policy-rule create -a medium -m processing_time PROCESSING_TIME  > /dev/null
ceilometer-upgrade  > /dev/null
gnocchi-upgrade  > /dev/null