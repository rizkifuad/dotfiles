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
  timeout 660 'mmsg dispatch sleep_monitor,DP-2 && mmsg dispatch sleep_monitor,HDMI-A-2' \
  timeout 900 'systemctl suspend' \
  resume 'mmsg dispatch wake_monitor,DP-2 && mmsg dispatch wake_monitor,HDMI-A-2' &
