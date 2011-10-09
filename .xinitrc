#!/bin/bash

xrdb -merge .Xdefaults
#gnome-settings-daemon&
exec awesome
#exec ck-launch-session wmfs
#exec ck-launch-session gnome-session
