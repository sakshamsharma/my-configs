#! /bin/bash

echo "To see current swappiness value do: "
echo "\# cat /proc/sys/vm/swappiness"

echo "To change swappiness value temporarily: "
echo "\# sysctl vm.swappiness=10"

echo "To permanently change it, in /etc/sysctl.d/99-sysctl.conf, do: "
echo "\# vm.swappiness=10"
