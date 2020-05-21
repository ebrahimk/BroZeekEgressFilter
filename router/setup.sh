#!/bin/ash

mkdir -p /var/lock &&
opkg update &&
opkg install uhttpd &&
opkg update &&
opkg install luci
