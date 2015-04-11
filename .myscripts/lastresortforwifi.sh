#! /bin/bash
# This must be used only when nothing else is possible
echo "options rtl8723be fwlps=0" | sudo tee /etc/modprobe.d/rtl8723be.conf

# If that doesn't work, try 'sudo iwconfig power off' to switch off power management
