 mount nethome
 gnome-settings-daemon & # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
 nm-applet &             # assuming you're using Network Manager
 #pidgin &                # if you're using pidgin. You can really put any programs here.
 gnome-volume-manager &  # for mounting CDs, USB sticks, and such
 gnome-volume-control-applet&
 hp-systray&
 xrdb -merge .Xdefaults
 dropbox start
 exec awesome            # awesome receives xinit's process id; when it terminates, X will be terminate
