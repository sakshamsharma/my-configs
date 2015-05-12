#!/bin/bash	
echo "Setting to powersaver with min freq 800Mhz"
cpupower frequency-set -g powersave
echo "Remaining configuration in /etc/default/cpupower"
echo "Use cpupower frequency-set 2000MHz if you feel your laptop is slow."
echo "Use 'watch grep \"cpu MHz\" /proc/cpuinfo' to check current speed."
