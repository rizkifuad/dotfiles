 #!/bin/bash
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
export STEAM_USE_MANGOAPP=1
export MANGOHUD_CONFIGFILE=$HOME/.config/mangohud/mangohud.conf

export STEAM_USE_DYNAMIC_VRS=1
export RADV_FORCE_VRS_CONFIG_FILE=$(mktemp /tmp/radv_vrs.XXXXXXXX)



# Enable tearing controls in steam
export STEAM_GAMESCOPE_TEARING_SUPPORTED=1
export STEAM_GAMESCOPE_HAS_TEARING_SUPPORT=1

export GAMESCOPE_NV12_COLORSPACE=k_EStreamColorspace_BT601

# Workaround older versions of vkd3d-proton setting this
# too low (desc.BufferCount), resulting in symptoms that are potentially like
# swapchain starvation.
export VKD3D_SWAPCHAIN_LATENCY_FRAMES=3


# Initially write no_display to our config file
# so we don't get mangoapp showing up before Steam initializes
# on OOBE and stuff.
mkdir -p "$(dirname "$MANGOHUD_CONFIGFILE")"
echo "no_display" > "$MANGOHUD_CONFIGFILE"

# Prepare our initial VRS config file
# for dynamic VRS in Mesa.
mkdir -p "$(dirname "$RADV_FORCE_VRS_CONFIG_FILE")"
echo "1x1" > "$RADV_FORCE_VRS_CONFIG_FILE"

# To expose vram info from radv
export WINEDLLOVERRIDES=dxgi=n

# Workaround for steam getting killed immediatly during reboot
export STEAMOS_STEAM_REBOOT_SENTINEL="/tmp/steamos-reboot-sentinel"

# Workaround for steam getting killed immediatly during shutdown
# Same idea as reboot sentinel above
export STEAMOS_STEAM_SHUTDOWN_SENTINEL="/tmp/steamos-shutdown-sentinel"

# Enable volume key management via steam for this session
export STEAM_ENABLE_VOLUME_HANDLER=1

# Have SteamRT's xdg-open send http:// and https:// URLs to Steam
export SRT_URLOPEN_PREFER_STEAM=1

# Disable automatic audio device switching in steam, now handled by wireplumber
export STEAM_DISABLE_AUDIO_DEVICE_SWITCHING=1

# Enable support for xwayland isolation per-game in Steam
export STEAM_MULTIPLE_XWAYLANDS=1

# We have the Mesa integration for the fifo-based dynamic fps-limiter
export STEAM_GAMESCOPE_DYNAMIC_FPSLIMITER=1

# We have gamma/degamma exponent support
export STEAM_GAMESCOPE_COLOR_TOYS=1

# We have NIS support
export STEAM_GAMESCOPE_NIS_SUPPORTED=1

# Don't wait for buffers to idle on the client side before sending them to gamescope
export vk_xwayland_wait_ready=false

# Let steam know it can unmount drives without superuser privileges
export STEAM_ALLOW_DRIVE_UNMOUNT=1

# We no longer need to set GAMESCOPE_EXTERNAL_OVERLAY from steam, mangoapp now does it itself
export STEAM_DISABLE_MANGOAPP_ATOM_WORKAROUND=1

# Enable horizontal mangoapp bar
export STEAM_MANGOAPP_HORIZONTAL_SUPPORTED=1

# Scaling support
export STEAM_GAMESCOPE_FANCY_SCALING_SUPPORT=1

# Set input method modules for Qt/GTK that will show the Steam keyboard
export QT_IM_MODULE=steam
export GTK_IM_MODULE=Steam

# To play nice with the short term callback-based limiter for now
export GAMESCOPE_LIMITER_FILE=$(mktemp /tmp/gamescope-limiter.XXXXXXXX)

# Use SteamOS background if exists
if [ -f "/usr/share/steamos/steamos.png" ] ; then
  export STEAM_UPDATEUI_PNG_BACKGROUND=/usr/share/steamos/steamos.png
fi

ulimit -n 524288

# Source user configuration from ~/.config/environment.d
set -a
for i in "${HOME}"/.config/environment.d/*.conf; do
	[[ -f "${i}" ]] && . "${i}"
done
set +a

# Setup socket for gamescope
# Create run directory file for startup and stats sockets
tmpdir="$([[ -n ${XDG_RUNTIME_DIR+x} ]] && mktemp -p "$XDG_RUNTIME_DIR" -d -t gamescope.XXXXXXX)"
socket="${tmpdir:+$tmpdir/startup.socket}"
stats="${tmpdir:+$tmpdir/stats.pipe}"
# Fail early if we don't have a proper runtime directory setup
if [[ -z $tmpdir || -z ${XDG_RUNTIME_DIR+x} ]]; then
	echo >&2 "!! Failed to find run directory in which to create stats session sockets (is \$XDG_RUNTIME_DIR set?)"
	exit 0
fi

export GAMESCOPE_STATS="$stats"
mkfifo -- "$stats"
mkfifo -- "$socket"

# Attempt to claim global session if we're the first one running (e.g. /run/1000/gamescope)
linkname="gamescope-stats"
#   shellcheck disable=SC2031 # (broken warning)
sessionlink="${XDG_RUNTIME_DIR:+$XDG_RUNTIME_DIR/}${linkname}" # Account for XDG_RUNTIME_DIR="" (notfragileatall)
lockfile="$sessionlink".lck
exec 9>"$lockfile" # Keep as an fd such that the lock lasts as long as the session if it is taken
if flock -n 9 && rm -f "$sessionlink" && ln -sf "$tmpdir" "$sessionlink"; then
	# Took the lock.  Don't blow up if those commands fail, though.
	echo >&2 "Claimed global gamescope stats session at \"$sessionlink\""
else
	echo >&2 "!! Failed to claim global gamescope stats session"
fi

# Use cursor if file exist
if [ -z "$CURSOR_FILE" ] ; then
    CURSOR_FILE="${HOME}/.local/share/Steam/tenfoot/resource/images/cursors/arrow_right.png"
fi
CURSOR=""
if [ -f "$CURSOR_FILE" ] ; then
    CURSOR="--cursor ${CURSOR_FILE}"
fi

# Define session if not overriden
if [ -z "$STEAMCMD" ] ; then
    STEAMCMD="steam -gamepadui -steamos3 -steampal -steamdeck"
fi

if [ -z "$GAMESCOPECMD" ] ; then

     #RESOLUTION="-W 3840 -H 2160"
    GAMESCOPECMD="/usr/bin/gamescope \
      $CURSOR \
      -e \
      $RESOLUTION \
      --xwayland-count 4 \
      -O DP-1,DP-3,*,eDP-1 \
      --default-touch-mode 4 \
      --hide-cursor-delay 3000 \
      --fade-out-duration 200 \
      --generate-drm-mode cvt \
      --immediate-flips \
      --adaptive-sync \
      -R $socket -T $stats"
else
    # Add socket and stats read
    GAMESCOPECMD+=" -R $socket -T $stats"
fi

# Workaround for Steam login issue while Steam client change propagates out of Beta
touch "${HOME}"/.steam/root/config/SteamAppData.vdf || true

# Log rotate the last session
if [ -f "${HOME}"/.steam-tweaks.log ]; then
    cp "${HOME}"/.steam-tweaks.log "${HOME}"/.steam-tweaks.log.old
fi
if [ -f "${HOME}"/.steam-stdout.log ]; then
    cp "${HOME}"/.steam-stdout.log "${HOME}"/.steam-stdout.log.old
fi
if [ -f "${HOME}"/.gamescope-stdout.log ]; then
    cp "${HOME}"/.gamescope-stdout.log "${HOME}"/.gamescope-stdout.log.old
fi

# Start gamescope compositor, log it's output and background it
$GAMESCOPECMD > "${HOME}"/.gamescope-stdout.log 2>&1 &
gamescope_pid="$!"

if read -r -t 3 response_x_display response_wl_display <> "$socket"; then
	export DISPLAY="$response_x_display"
	export GAMESCOPE_WAYLAND_DISPLAY="$response_wl_display"
	# We're done!
else
	kill -9 "$gamescope_pid"
	wait
	exit 0
	# Systemd or Session manager will have to restart session
fi

# Run steam-tweaks if exists
if command -v steam-tweaks > /dev/null; then
    steam-tweaks > "${HOME}"/.steam-tweaks.log
fi

# Input method support if present
if command -v /usr/bin/ibus-daemon > /dev/null; then
    /usr/bin/ibus-daemon -d -r --panel=disable --emoji-extension=disable
fi

# If we have mangoapp binary start it
if command -v mangoapp > /dev/null; then
    mangoapp > "${HOME}"/.mangoapp-stdout.log 2>&1 &
fi

# Start Steam client
$STEAMCMD > "${HOME}"/.steam-stdout.log 2>&1

# When the client exits, kill gamescope nicely
kill $gamescope_pid

# Start a background sleep for five seconds because we don't trust it
sleep 5 &
sleep_pid="$!"

# Catch reboot and poweroof sentinels here
if [[ -e "$STEAMOS_STEAM_REBOOT_SENTINEL" ]]; then
	rm -f "$STEAMOS_STEAM_REBOOT_SENTINEL"
	reboot
fi
if [[ -e "$STEAMOS_STEAM_SHUTDOWN_SENTINEL" ]]; then
	rm -f "$STEAMOS_STEAM_SHUTDOWN_SENTINEL"
	poweroff
  #kill -9 $gamescope_pid
fi

# Wait for gamescope or the sleep to finish for timeout purposes
ret=0
wait -n $gamescope_pid $sleep_pid || ret=$?

# If we get a SIGTERM/etc while waiting this happens.  Proceed to kill -9 everything but complain
if [[ $ret = 127 ]]; then
	echo >&2 "gamescope-session: Interrupted while waiting on teardown, force-killing remaining tasks"
fi

# Kill all remaining jobs and warn if unexpected things are in there (should be just sleep_pid, unless gamescope failed
# to exit in time or we hit the interrupt case above)
for job in $(jobs -p); do
	# Warn about unexpected things
	if [[ $ret != 127 && $job = "$gamescope_pid" ]]; then
		echo >&2 "gamescope-session: gamescope timed out while exiting, killing"
	elif [[ $ret != 127 && $job != "$sleep_pid" ]]; then
		echo >&2 "gamescope-session: unexpected background pid $job at teardown: "
		# spew some debug about it
		ps -p "$job" >&2
	fi
	kill -9 "$job"
done
