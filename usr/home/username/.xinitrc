# Load custom options (cursor theme, u-rxvt theme...)
xrdb ~/.Xresources

# Screen always on
xset s off
xset -dpms

# Set default volume to 50%
sysctl hw.snd.default_unit=4
mixer vol 50
sysctl hw.snd.default_unit=5
mixer vol 50
sysctl hw.snd.default_unit=4

# Compton
compton -CGb --vsync opengl --no-fading-openclose &

# SSH database
eval "$(ssh-agent -s)"

# i3
exec /usr/local/bin/i3

