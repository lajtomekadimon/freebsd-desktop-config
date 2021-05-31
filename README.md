# Lajto's FreeBSD desktop config
My personal configuration for FreeBSD in desktop. It's designed for my personal
case, so please don't use it; there are still some unresolved issues.

This configuration uses i3 wm in a SSD + AMD Ryzen + NVIDIA environment.

## Known issues

- Microphone can't be used properly.
- Webcam can't be used properly.

## Installation

- Keymap: es.kbd
- Hostname: lajto-bsd
- Optional system components to install:
    - kernel-dbg
    - lib32
    - ports
    - src
- Partitioning: Auto (ZFS) (swap size: 8G)
- Services to be started at boot:
    - sshd
    - ntpd
    - powerd
    - dumpdev
- System security hardening options: all of them
- Create `lajto` user and add it to the `wheel` group.

# Configuration

Log in as `root` user.

Run this:

```sh
# Ports
/usr/sbin/pkg

# Git
pkg install devel/git

# Download configuration
git clone https://github.com/lajtomekadimon/freebsd-desktop-config

cd freebsd-desktop-config
```

Configure FreeBSD:

```sh
# Configure (many confirmations will be required)
make configure
cd ..
rm -Rf freebsd-desktop-config

# Reboot
reboot
```

Log in as `lajto` user and run Xorg:

```sh
startx
```

Open Firefox and run `about:config` in the dir bar:

- Set `ui.context_menus.after_mouseup` to `true`.
- Set `extensions.pocket.enabled` to `false`.
- Set `middlemouse.paste` to `false`.
- Set `layers.acceleration.force-enabled` to `true`.
- Set `browser.download.animateNotifications` to `false`.
- Set `image.mem.animated.discardable` to `false`.
- Create new value called `widget.content.gtk-theme-override`: `Adwaita`.

Mount the second hard drive:

```sh
zpool import mydata

# Mount external ZFS drive
#zpool import mydataext
# Umount external ZFS drive
#zpool export mydataext
```

Done.

Note about second hard drive; I did it like this:

```sh
dd if=/dev/zero of=/dev/ada1 bs=1m  # Set all bits to 0

glabel label -v mydata /dev/ada1  # Set 'mydata' as the label

zpool create mydata /dev/label/mydata  # Create ZFS pool

chown -R lajto /mydata  # Set permissions
```

# Updates

Update packages:

```sh
pkg upgrade
```

Update FreeBSD system:

```sh
freebsd-update fetch
freebsd-update install
```

# Mounting external devices

In FAT32 and NTFS, I assume the device is `da0` (a second one would be da1);
if you want to mount a second device at the same time, use `usb02`.

FAT32 (change `lajto` to your username):

```sh
mount_msdosfs -u lajto -g lajto /dev/da0s1 /media/usb01
```

NTFS:

```sh
ntfs-3g -o nosuid,noexec /dev/da0 /media/usb01
```

EXT4:

```sh
mount -t ext2fs /dev/da0p1 /media/usb01
```

MTP (Android, iPhone...):

```sh
simple-mtpfs /media/android -o allow_other
```
