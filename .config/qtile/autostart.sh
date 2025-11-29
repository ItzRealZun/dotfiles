#!/usr/bin/env bash

#Sound level
amixer sset Master 63

#Notifications and wallpaper
dunst & hyprpaper &
