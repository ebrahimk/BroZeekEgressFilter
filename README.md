# BroZeekEgressFilter

This repo houses all code for the Network Security final project demonstrating ifferent types of DoS attacks. 

## Installation

The test enviroment consists of nine containers running on 4 different subnets. Each subnet references a unqiue gateway (also running in a container) resposible for routing packets to the gateways of other subnets. 

To start the enviroment run:

```bash
$ docker-compose --compatibility up 
```

Once all of the containers are running you can view runnign containers with the following command. 

```bash 
$ docker ps
````

You can inspect the IP address of any running containers with the below command. Notice that running containers with matching prefixes are running on the same subnet. Containers with "router" in the names are responsible for routing packets addressed outside the subnet. 

```bash
$ docker inspect <containerNameOrId> | grep '"IPAddress"' | head -n 1
```

You can open a shell to any running container using the following command. Try the following:

```bash
# get the ip address of the victim container
$ docker inspect brozeekegressfilter_victim_1 | grep '"IPAddress"'

# open a shell to a running container
$ docker exec -it brozeekegressfilter_attacker_1 /bin/ash

# From within the attacker container, verify that the attacker is on a subnet outside the victim container
$ ip a | grep "inet"

# From within the attacker container shell run
$ ping <victimIpAddress>
```

You should see a response from the ping indicating that routing is working to and from the subnet. 

## Zeek Script

The Zeek script created for this project produces log files containing the source and destination ip addresses, and a boolean which indicates if the packet's source IP was spoofed. 

To run the Zeek instance: 

```bash
zeek -i <NETWORK_INTERFACE> main.zeek
```

The logs are stored in egress.log. A Zeek instance is run on the container behaving as the router for the attacker on the network. 

## Elastic Stack

The /elastic_stack directory contains a compose file for setting up containers running a Filebeat, Elastic Search and Kibana instance which read .log files in realtime from a Zeek instance running a container. The Kibana dashboard for visualizing these logs still needs to be completed. The Zeek script which demonstrates egress tagging can be injected into the container running zeek at runtime. 

## Running the demo

To execute the demo run the following commands.

```bash
$ ./setup.sh
$ cd elastic_stack && docker-compose up
```

This will spin up the entire container infrastructure with a Zeek instance on the victim container and the router for the attacker subnet.
This will also start a Elastic Search, Filebeat and Kibana instances. Kibana is hosted on port 5601. To stage the attack open a shell to the attacker container. Zeek logs are collected from the router on the attacker subnet and the victim container. The are located at: "./zeek/egress.log" and "./zeek/victim/victim.log." They are automatically read in real time by Filebeat and pushed to the Elastic Search instance for easy monitoring with Kibana. The logs will not be generated unless network traffic starts. 

```bash
$ docker exec -it  brozeekegressfilter_attacker_1 /bin/bash
```

Now send a spoofed ping flood to the victim. 


```bash
$ hping3 -1 --rand-source 172.20.3.2 --flood
```

Verify that the link is saturated by opening a shell to a bystandard container and sending a ping to the victim:

```bash
$ docker exec -it brozeekegressfilter_reflection_1 /bin/bash
$ ping 172.20.3.2
```

## Egress Filter

Open a shell to the router on the attacker subnet. 

```bash
$ docker exec -it  brozeekegressfilter_attacker_router_1 /bin/bash
```

Create IPTable rule for Egress filtering out all spoofed IP addresses generated on the attacker subnet. 

```bash
$ iptables -A FORWARD  -i eth0 ! -s 172.20.2.0/24  -j DROP
```

Verify that packets with spoofed IP's are getting caught.

```bash
$ iptables -L -v
```
