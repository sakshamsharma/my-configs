#! /bin/bash

# amixer sset Master 100%

# Get all sounds sources, get their names, form a command line with amixer and execute it
# amixer scontrols | grep -oE "'.*'" | awk -F\' \
# '{print "amixer -c 0 set \""$2"\" unmute 100"}' | sh
# Unmutes all audio devices and sets their volume to max.

# Basic setup for sound:
# Do a sudo systemctl enable alsa-restore
# And then start it
# Then do amixer sset Master unmute (add this to startup)
