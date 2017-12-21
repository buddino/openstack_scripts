#!/bin/bash

### Example of experiment ###
# EXP_NAME=PROVA			
# TIME=3
# VFs["VF1_DC1"]=10.0.0.1,10M
# VFs["VF2_DC1"]=10.0.0.2,3M
# VFs["VF3_DC1"]=10.0.0.3,5M
# ...
# VFs["NOME"]=IP,BANDWIDTH
#############################

#Check arguments
if [ $# -eq 0 ]; then
        echo "Usage: $0 experiment_file"
        exit;
fi

#Read experiment
declare -A VFs #Declare array
if [ ! -e $1 ]; then
        echo "Experiment not found!"
        exit;
fi
EXP_NAME=$1
source $1

#Check if an experiment with the same name already exists
if [ -e Results/$EXP_NAME ]; then
        echo "An experiment with the same name already exists"
        exit;
fi

mkdir -p "Results/$EXP_NAME"
IFS=,
echo "Starting experiment $EXP_NAME, sending data for $TIME seconds"
for VF_NAME in "${!VFs[@]}"; do
        read -ra values <<< "${VFs[$VF_NAME]}"
        BANDWIDTH=${values[1]}
        IP=${values[0]}
        echo $VF_NAME: $IP - Bandwidth: $BANDWIDTH
        iperf3 -c $IP -b $BANDWIDTH -t $TIME -J | ./converter.py > "Results/$EXP_NAME/$VF_NAME"  &
done

function usage {
    echo "usage: $0 experiment"
    exit 1
}
