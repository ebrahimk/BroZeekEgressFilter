#!/bin/bash

docker-compose rm -f

docker kill brozeekegressfilter_attacker_router_1 \
			brozeekegressfilter_victim_router_1 \
			brozeekegressfilter_reflection_router_1 \
			brozeekegressfilter_victim_1 \
			brozeekegressfilter_attacker_1 \

docker container rm $(docker ps -a -q)

docker image rm brozeekegressfilter_attacker \
		brozeekegressfilter_victim \
		brozeekegressfilter_reflection \
		brozeekegressfilter_attacker_router  

docker network rm \
	brozeekegressfilter_attacker_net \
	brozeekegressfilter_victim_net \
	brozeekegressfilter_reflection_net \
	brozeekegressfilter_router_net

rm ./zeek/*.log
rm ./zeek/victim/*.log
rm -rf ./data/nodes

