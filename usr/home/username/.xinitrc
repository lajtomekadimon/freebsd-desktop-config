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

# SSH database
eval "$(ssh-agent -s)"

# ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
/usr/local/bin/mozc start
ibus-daemon -r --daemonize --xim
export QT_IM_MODULE=ibus

# picom (compton's replacement)
picom -CGb --vsync opengl --no-fading-openclose &

# i3
exec /usr/local/bin/i3
