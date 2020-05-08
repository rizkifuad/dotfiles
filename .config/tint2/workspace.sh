while [ -z "$(pgrep polybar)" ]; do
    echo "tint2 waiting for main bar"
done
sleep 1
# sleep 2
tint2 /home/rizki/.config/tint2/workspace.tint2
