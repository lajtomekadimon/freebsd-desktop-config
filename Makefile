USERNAME=lajto

freebsd-conf:
	echo "LANG=en_US.UTF-8; export LANG" >> /etc/profile
	echo "CHARSET=UTF-8; export CHARSET" >> /etc/profile
	# FreeBSD config files
	rm -f /boot/loader.conf && mv boot/loader.conf /boot/loader.conf
	rm -f /etc/devfs.conf && mv etc/devfs.conf /etc/devfs.conf
	rm -f /etc/devfs.rules && mv etc/devfs.rules /etc/devfs.rules
	rm -f /etc/fstab && mv etc/fstab /etc/fstab
	rm -f /etc/pf.conf && mv etc/pf.conf /etc/pf.conf
	rm -f /etc/rc.conf && mv etc/rc.conf /etc/rc.conf
	rm -f /etc/sysctl.conf && mv etc/sysctl.conf /etc/sysctl.conf
	# Add user to operator group (poweroff, reboot, mount...)
	pw groupmod operator -M $(USERNAME)
	pw groupmod wheel -M $(USERNAME)

dirs:
	# External USB devices mounts
	mkdir -p /media/usb01
	chown $(USERNAME) /media/usb01
	mkdir -p /media/usb02
	chown $(USERNAME) /media/usb02
	mkdir -p /media/android
	chown $(USERNAME) /media/android
	# Create some folders
	mkdir -p /usr/home/$(USERNAME)/Screenshots
	chown $(USERNAME) /usr/home/$(USERNAME)/Screenshots
	mkdir -p /usr/home/$(USERNAME)/Repos
	chown $(USERNAME) /usr/home/$(USERNAME)/Repos
	mkdir -p /usr/home/$(USERNAME)/Downloads
	chown $(USERNAME) /usr/home/$(USERNAME)/Downloads
	mkdir -p /usr/home/$(USERNAME)/Documents
	chown $(USERNAME) /usr/home/$(USERNAME)/Documents

xorg:
	# Install Xorg
	pkg install x11/xorg
	# Load Linux support
	kldload linux
	kldload linux64
	# Install NVIDIA
	pkg install x11/nvidia-driver
	pkg install x11/nvidia-settings
	# Install fonts
	pkg install chinese/arphicttf chinese/font-std \
	hebrew/culmus hebrew/elmar-fonts japanese/font-ipa \
	japanese/font-ipa-uigothic japanese/font-ipaex japanese/font-kochi \
	japanese/font-migmix japanese/font-migu japanese/font-mona-ipa \
	japanese/font-motoya-al japanese/font-mplus-ipa japanese/font-sazanami \
	japanese/font-shinonome japanese/font-takao japanese/font-ume \
	japanese/font-vlgothic x11-fonts/hanazono-fonts-ttf \
	japanese/font-mikachan korean/aleefonts-ttf korean/nanumfonts-ttf \
	korean/unfonts-core x11-fonts/anonymous-pro x11-fonts/artwiz-aleczapka \
	x11-fonts/dejavu x11-fonts/inconsolata-ttf x11-fonts/terminus-font \
	x11-fonts/cantarell-fonts x11-fonts/droid-fonts-ttf x11-fonts/doulos \
	x11-fonts/ubuntu-font x11-fonts/isabella x11-fonts/junicode \
	x11-fonts/khmeros x11-fonts/padauk x11-fonts/stix-fonts \
	x11-fonts/charis x11-fonts/urwfonts-ttf russian/koi8r-ps \
	x11-fonts/geminifonts x11-fonts/cyr-rfx x11-fonts/paratype \
	x11-fonts/gentium-plus x11-fonts/sourcecodepro-ttf x11-fonts/noto \
	x11-fonts/roboto-fonts-ttf x11-fonts/powerline-fonts x11-fonts/hack-font \
	x11-fonts/intlfonts
	mkdir -p /usr/home/$(USERNAME)/.config/fontconfig
	mv usr/home/username/.config/fontconfig/fonts.conf \
	/usr/home/$(USERNAME)/.config/fontconfig/fonts.conf
	# Fix fonts
	cd /usr/local/etc/fonts/conf.d; ln -s ../conf.avail/70-no-bitmaps.conf
	# Xorg config
	mv usr/local/etc/X11/xorg.conf.d /usr/local/etc/X11/
	mkdir -p /usr/home/$(USERNAME)/.icons/
	ln -s /usr/share/cursors/xorg-x11 /usr/home/$(USERNAME)/.icons
	rm -f /usr/home/$(USERNAME)/.gtkrc-2.0
	mv usr/home/username/.gtkrc-2.0 /usr/home/$(USERNAME)/.gtkrc-2.0
	mkdir -p /usr/home/$(USERNAME)/.config/gtk-3.0
	rm -f /usr/home/$(USERNAME)/.config/gtk-3.0/settings.ini && mv \
	usr/home/username/.config/gtk-3.0/settings.ini \
	/usr/home/$(USERNAME)/.config/gtk-3.0/settings.ini

i3wm:
	# Install and configure i3
	pkg install x11-wm/i3 x11/i3status x11/i3lock x11/dmenu \
	x11/rxvt-unicode graphics/scrot \
	x11-themes/adwaita-icon-theme x11-themes/adwaita-qt \
	x11-themes/gtk-arc-themes x11-themes/gnome-themes-extra
	rm -f /usr/home/$(USERNAME)/.cshrc
	mv usr/home/username/.cshrc /usr/home/$(USERNAME)/.cshrc
	rm -f /usr/home/$(USERNAME)/.xinitrc
	mv usr/home/username/.xinitrc /usr/home/$(USERNAME)/.xinitrc
	rm -f /usr/home/$(USERNAME)/.Xresources
	mv usr/home/username/.Xresources /usr/home/$(USERNAME)/.Xresources
	mkdir -p /usr/home/$(USERNAME)/.config/i3/
	rm -f /usr/home/$(USERNAME)/.config/i3/config
	mv usr/home/username/.config/i3/config \
	/usr/home/$(USERNAME)/.config/i3/config
	mkdir -p /usr/home/$(USERNAME)/.config/i3status/
	rm -f /usr/home/$(USERNAME)/.config/i3status/config
	mv usr/home/username/.config/i3status/config \
	/usr/home/$(USERNAME)/.config/i3status/config
	mv usr/home/username/.i3-wallpaper.png \
	/usr/home/$(USERNAME)/.i3-wallpaper.png

software:
	# Install file compression utilities
	pkg install archivers/zip archivers/unzip archivers/unrar \
	archivers/p7zip archivers/p7zip-codec-rar
	# Install terminal software
	pkg install sysutils/screenfetch sysutils/neofetch editors/vim \
	sysutils/tmux sysutils/py-glances sysutils/py-ranger \
	multimedia/musikcube graphics/feh graphics/mupdf audio/mixertui \
	misc/cloc
	# Install GUI software
	pkg install \
	www/firefox x11-fm/pcmanfm graphics/eom \
	graphics/atril editors/mousepad \
	archivers/engrampa multimedia/mpv graphics/gimp graphics/inkscape \
	graphics/blender audio/audacity audio/kid3-qt5 \
	editors/libreoffice net-p2p/transmission-gtk \
	sysutils/xfburn math/geogebra \
	security/keepassxc net-im/telegram-desktop \
	games/anki
	# Install extra web browsers
	pkg install www/chromium
	# Install Japanese and Chinese keyboard support
	pkg install textproc/ibus japanese/ibus-mozc chinese/ibus-libpinyin
	# LaTeX
	pkg install print/texlive-full print/latex-biber
	# Video games
	pkg install emulators/dolphin-emu emulators/pcsxr
	# Webcam support
	pkg install multimedia/webcamd multimedia/v4l_compat \
	multimedia/v4l-utils
	pw groupmod webcamd -m $(USERNAME)
	# Start PF
	service pf start
	pfctl -f /etc/pf.conf
	# NTFS
	pkg install sysutils/fusefs-ntfs
	# MTP (Android, iPhone...)
	pkg install sysutils/fusefs-simple-mtpfs
	# VirtualBox
	pkg install emulators/virtualbox-ose
	pw groupmod vboxusers -m $(USERNAME)
	# Vim
	rm -f /usr/home/$(USERNAME)/.vimrc
	wget -O /usr/home/$(USERNAME)/.vimrc \
	https://raw.githubusercontent.com/lajtomekadimon/vim-config/main/.vimrc
	# Change permissions
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.config
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.icons
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.Xresources
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.i3-wallpaper.png
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.gtkrc-2.0
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.xinitrc
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.cshrc
	chown -R $(USERNAME) /usr/home/$(USERNAME)/.vimrc
	# wvim
	cp usr/home/username/.wvim.sh /usr/home/$(USERNAME)/.wvim.sh
	chmod a+x /usr/home/$(USERNAME)/.wvim.sh
	ln -s /usr/home/$(USERNAME)/.wvim.sh /usr/bin/wvim

configure: freebsd-conf dirs xorg i3wm software
