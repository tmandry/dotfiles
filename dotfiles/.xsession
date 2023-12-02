#!/bin/sh

gnome-settings-daemon & # handles themes, starts
                        # gnome-screensaver. You may
                        # have to use gconf to disable
                        # it setting the background.

xautolock -time 5 -locker "gnome-screensaver-command -l" &

#gnome-volume-manager &  # for auto-mounting CDs, USB
                        # sticks, and such

parcellite &

exec i3
