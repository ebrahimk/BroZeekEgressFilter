#!/bin/ash

route delete default gw $DEFAULT_IP eth0
route add default gw $GATEWAY_IP eth0
tail -f /dev/null

