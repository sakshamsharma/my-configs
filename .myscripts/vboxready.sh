#! /bin/bash

sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt
sudo modprobe vboxpci
sudo modprobe vboxvideo
VBoxClient-all
sudo systemctl start vboxservice
