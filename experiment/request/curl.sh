#!/bin/bash
URI=http://192.168.9.121:3000

#Check arguments
if [ ! $# -eq 3 ]; then
        echo "Usage: $0 SOURCE DESTINATION CHAIN (e.g. $0 VF-1 VF-2 VF-4,VF-3)"
        exit;
fi

SRC=$1
DST=$2
CHAIN=$3

BODY='{"num_req": 1,"serviceType": "Type1","maxLatency": 100,"bandwidth": 100,"source": "'$SRC'","destination": "'$DST'","vfChain": "'$CHAIN'"}'

curl -d "$BODY" -H "Content-Type: application/json" -X POST $URI
