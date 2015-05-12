#! /bin/bash
# This must be used only when nothing else is possible
echo "options rtl8723be fwlps=0" | sudo tee /etc/modprobe.d/rtl8723be.conf

# There is another command here:
# sudo modprobe iwlwifi lln_disable=1 swcrypto=1 fwlps=0

# If that doesn't work, try 'sudo iwconfig power off' to switch off power management
