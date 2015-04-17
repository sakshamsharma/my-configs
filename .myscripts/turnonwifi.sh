#! /bin/bash
# Script to turn on my WiFi interfaces on my laptop.

interface=$(rfkill list | grep -E "([L][A][N])" | grep -E "^[0-9]" -o)
for x in $interface;
do
	rfkill unblock $x
done
