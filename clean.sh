#!/bin/bash

docker-compose rm -f

docker image rm brozeekegressfilter_attacker \
		brozeekegressfilter_victim \
		brozeekegressfilter_attacker_router  

docker network rm \
	brozeekegressfilter_attacker_net \
	brozeekegressfilter_victim_net	 
