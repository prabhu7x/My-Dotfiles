- [alacritty](#alacritty)
- [xmodmap](#xmodmap)
- [dmenu](#dmenu)
- [tar package](#instaling-targz)
- [Xresources](#reload-xresource)
- [makepkg](#to-make-makepkg-faster)
- [sudo](#sudo)
- [git](#to-download-particular-directory-instead-of-clone-whole-repo)
- [npm](#npm)
- [find](#find-files-based-on-size)
- [virt-manager](#virt-manager)
- [change Root](#chroot)
- [packman](#pacman)
- [bluetooth](#bluetooth)
- [dragon](#dragon)
- [without sudo](#without-sudo)
- [flash iso](#dd)

* to find window class or name
  - xprop and click on window desired window
* auto update time and date
  - ntp
    and run timdedatectl set-ntp true

# Default application settings in arch

- to find file type

  - _xdg-mime query filetype (file path)_

- setting default application

  - _xdg-mime default (application name.desktop) (filetype)_

- to find defualt application
  xdg-mime query default (filetype)

  - [change .locale/share/applications/ for non-xdg]

#### to change default application

.config/mimeapps.list

#### to make makepkg faster

1.  modify /etc/makepkg.conf
2.  MAKEFLAGS="-Jx" (x=cpu)

### sudo

- to become su user (live iso test most cases)

  - _sudo su_

    or

  - sudo add 'username'
    and then when asking for su password type 'username' password

# alacritty

- to create a empty window
  - alacritty msg create-window -e alacritty

# xmodmap

#### input , keycodes

- xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
  to map key
  xmodmap -e 'keycode num = name'
- to save it file
  xmodmap -pke > .Xmodmap

# dmenu

#### dmenu no locar support

1. Edit the file /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 (if it isn't already).
2. Run sudo locale-gen to generate the updated locale.
3. Run sudo localectl set-locale LANG=en_US.UTF-8 to set that particular locale.
4. Reboot.

- ~/.config/dmenu-recent/terminal
  to change a choice in dmenu backgorund, terminal and terminalhol

### instaling tar.gz

- take the tar.gz from the AUR, extract it, run "makepkg" in that directory and then "pacman -U ???.pkg.tar.gz"

### To download particular directory instead of clone whole repo

1. copy url and change _tree/master_ to _trunk_
2. svn checkout **url**

#### Reload Xresource

xrdb ~/.Xresources

# vscode

- opening vite projects in specific browser
- - adding below line to vite.config.js (in create-react-app)

`process.env.BROWSER = "browser-name"`

# npm

### npm file exists error

- sudo pacman --overwrite "\*" -S npm

# find-files-based-on-size

- how to find above given size files in linux
- ChatGPT
-
- To find files of a specific size or above a certain size in Linux, you can use the find command. The find command allows you to search for files based on various criteria, including size. Here's how you can use it to find files of a given size or larger:
-
- bash
-
- find /path/to/search -type f -size +<size_specifier>
-
  > Replace /path/to/search with the directory where you want to start the search, and <size_specifier> with the size specification. The + symbol before the size specifier indicates files that are larger than the specified size.
-
- Size Specifiers:
- c: bytes (bytes)
- k: kilobytes (1024 bytes)
- M: megabytes (1024 kilobytes)
- G: gigabytes (1024 megabytes)
-
  > For example, to find files above 100 megabytes in the /home/user/documents directory:
-
- find /home/user/documents -type f -size +100M
-
- This command searches for files larger than 100 megabytes within the specified directory.
-
  > You can also specify size ranges using the -size option. For example, to find files between 50 megabytes and 100 megabytes:
-
- find /path/to/search -type f -size +50M -size -100M
-
  > Remember to adjust the directory path and size specifier according to your specific requirements.

# virt-manager

### start service and socket

- sudo pacman -S virt-manager qemu libvirt edk2-ovmf dnsmasq bridge-utils openbsd-netcat iptables-nft
- sudo systemctl libvirtd.service
- sudo systemctl libvirtd.socket
- sudo systemctl enable --now libvirtd.service
- sudo systemctl status libvirtd.service
- sudo vim /etc/libvirt/libvirtd.conf

> ` * To avoid no iso file or bootable img enable SATA CDROM1 and VirtIO Disk1 in > boot options * `
#### To extend storage

> `qemu-img resize source_path +10G
`
- source path can found in virtual disk details > virtIO Disk
>
> > in windows open **Disk management** and extend that _unallocated_ space
#### Share folder
- enable shared memory in virt-manager > memory
- click `Add Hardware > filesystem > browser target folder`
- on windows install **winFsm** from this site > `https://github.com/winfsp/winfsp/releases/`
- and goto this `https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/`
  > stable-virtio > virtio-win-guest-tools.exe
- startup virt service  from *services*

# chroot 
### change root in Arch linux
- mount root and boot partitions 
- - mount /dev/sdXY /mnt
- - mount /dev/sdXY /mnt/boot/efi
- > if it is **efi** then mount /boot/efi , if it is **boot** mount /boot
- - arch-chroot /mnt


# zip 
- create archive  zip archive.zip file1 file2 file3
- flags 
- - u for update, P for pre-password, e for post-password, m for move to archive, d for delete from archive (not extract when deleting)

# pacman 
- to ignore packages to update 
- - `sudo vim /ete/packman.conf`
- includes packages name in ignore = pkg-name pkg-name
- unable to lock  database 
- - sudo rm /var/lib/pacman/db.lck

# bluetooth
## how to connect to an android 
- enable and start bluetooth services in linux
- scan and select linux device name in android and tap on it
- run `bluetoothctl` in terminal to enter bluetooth control
- android name will visible on terminal copy it's mac address
- trust mac address
- connect mac address
- pair mac address
- tap on pair  on android device and enter yes (type full) in terminal when it asked.

# dragon
- make it excutable globally
- - install this in `/usr/bin` path 
- - or simply copy dragon file in `/usr/bin`

# without-sudo
`sudo setcap cap_net_raw,cap_net_admin+ep $(which <program name>)`
program path or simple use which <program name>
- to remove
`sudo setcap -r $(which <program name>)`

# dd
> sudo dd if=/path/to/iso of=/dev/sdX bs=4M status=progress