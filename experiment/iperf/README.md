# Traffic generator #
Create traffic towards the IP specified in the configuration file using iperf3 client.
An instance of iperf3 server on default port mst be running on the instances.

### Usage ###

*Remember to turn executability on for the iperf.sh and converter.py files*

`./iperf.sh experiment_file`

### Structure of the experiment file ###
```TIME=10
VFs["VF1_DC1"]=10.0.0.1,10M	
VFs["VF2_DC1"]=10.0.0.2,3M
VFs["VF3_DC1"]=10.0.0.3,5M
...
VFs["NOME"]=IP,BANDWIDTH```


### Structure of the output ###
