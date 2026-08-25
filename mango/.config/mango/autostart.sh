#!/bin/bash

set +e

# exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

foot -s &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# ensure xdg-desktop-portal running without last dirty state
# systemctl --user restart xdg-desktop-portal &

# waybar
# waybar &

swaybg -m fill -i ~/Pictures/Wallpapers/wall-01.jpg &

noctalia &


# inhibit by audio
# sway-audio-idle-inhibit >/dev/null 2>&1 &

#idle
swayidle -w \
  timeout 660 'wlopm --off *' \
  timeout 900 'systemctl suspend' \
  resume 'wlopm --on *' &
