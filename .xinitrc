#!/bin/bash

xrdb -merge .Xdefaults
#gnome-settings-daemon&
#exec awesome
exec wmfs
#exec ck-launch-session gnome-session
