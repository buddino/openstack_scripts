#!/bin/bash
URI=http://192.168.9.139:9999/api/post

#Check arguments
if [ ! $# -eq 2 ]; then
        echo "Usage: $0 requests_file sleep_time (e.g. $0 reqs1 5 i.e. sleep 5 seconds between requests) "
        exit;
fi

REQ_FILE=$1
SLEEP_TIME=$2

mkdir Results

#Check if an experiment with the same name already exists
if [ -e Results/$REQ_FILE ]; then
        echo "An experiment with the same name already exists"
        exit;
fi

for line in $(cat $REQ_FILE); do
        OLD_IFS=$IFS
        IFS=";"
        read -ra VAR <<< "${line}"
        SRC=${VAR[0]}
    DEST=${VAR[1]}
    CHAIN=${VAR[2]}
    echo "$SRC --> $DEST through $CHAIN"
        echo "$SRC --> $DEST through $CHAIN" >> "Results/$REQ_FILE"
    BODY='{"num_req": 1,"serviceType": "Type1","maxLatency": 100,"bandwidth": 100,"source": "'$SRC'","destination": "'$DEST'","vfChain": "'$CHAIN'"}'
    curl -d "$BODY" -H "Content-Type: application/json" -X POST $URI >> "Results/$REQ_FILE"
    echo $'\n' >> "Results/$REQ_FILE"
    echo "Sleeping for $SLEEP_TIME"
    sleep $SLEEP_TIME
    IFS=$OLD_IFS
done
