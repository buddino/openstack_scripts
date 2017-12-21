# Traffic generator #
Create traffic towards the IP specified in the configuration file using iperf3 client.
An instance of iperf3 server on default port mst be running on the instances.

### Usage ###

*Remember to turn executability on for the iperf.sh and converter.py files*

`./iperf.sh experiment_file`

### Structure of the experiment file
The *TIME* variable set for how long the traffic has to be sent to each host.
The VFs map contains the IP of the host and the bandwith of the traffic to be sent separated by comma.
You can remove (or comment) or add new just by adding a new line (e.g. `VFs["VF6_DC1"]=10.0.6.3,100M`).
The keys used in the map are not linked to the name of the instances on the DCs.
```
TIME=10
VFs["VF1_DC1"]=10.0.0.1,10M	
VFs["VF2_DC1"]=10.0.0.2,3M
VFs["VF3_DC1"]=10.0.0.3,5M
...
VFs["NOME"]=IP,BANDWIDTH
```


### Structure of the output ###
Inside the Results folder a new folder named as the experiment file will be created and filled with an output file for each connection displaying the mean and standard deviation computed with 1 second sampling rate.
```
VF1_DC1: 10.0.2.8 - Bandwidth: 1M
Sending traffic to: 10.0.2.8
-----------
MEAN: 0.96 Mbits/s
STD: 0.3 Mbits/s
-----------

```

To see all the outputs in a folder merged together you can use `cat * | less` (and use *Q* to exit)