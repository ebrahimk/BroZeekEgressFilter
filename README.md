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
$ docker inspect brozeekegressfilter_victim_1 | grep '"IPAddress"' | head -n 1

# open a shell to a running container
$ docker exec -it brozeekegressfilter_attacker_1 /bin/ash

# From within the attacker container, verify that the attacker is on a subnet outside the victim container
$ ip a | grep "inet"

# From within the attacker container shell run
$ ping <victimIpAddress>
```

You should see a response from the ping indicating that routing is working to and from the subnet. 

## Elastic Stack

The /elastic_stack directory contains a compose file for setting up containers running a Filebeat, Elastic Search and Kibana instance which read .log files in realtime from a Zeek instance running a container. The Kibana dashboard for visualizing these logs still needs to be completed. The Zeek script which demonstrates egress tagging can be injected into the container running zeek at runtime. 

# TODO

- Complete Elastic stack logging 
- Add Logstash instance for pre-filtering log data 
- Migrate all hardcoded IP addresses and container names to a .env file. 
