##  OpenSuse in Virtualbox / VMVare
Download [openSUSE 15.2 Leap](https://www.osboxes.org/opensuse/) image.
Choose KDE Plasma Version Version for GUI, OR Server Version for base "server mode".

Create virtual machine "demo", add downloaded disk image and boot.

Login as `root` (password `osboxes.org`), then change it using `passwd`. 
You can generate random password with `uuidgen` utility.

## Setup network
Inside guest run `yast`, configure network: `DHCP`, proxy (if required), firewall: enable `apache2` on public zone.

Confiure port forwarding (ssh 2222->22, www 8888->80)

```
VBoxManage modifyvm "demo" --natpf1 "guestssh,tcp,,2222,,22"
VBoxManage modifyvm "demo" --natpf1 "guesthttp,tcp,,8888,,80"
```

