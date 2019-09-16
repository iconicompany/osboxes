# Setup openSUSE

## Setup virtualbox
Download [openSUSE 15.1 Leap Server Version](https://www.osboxes.org/opensuse/) image
Create virtual machine "demo", add downloaded disk image and boot.

## Setup network
Run yast, configure DHCP, proxy (if required), firewall (enable apache2)

Confiure port forwarding (ssh 2222->22, www 8888->80)

```
VBoxManage modifyvm "demo" --natpf1 "guestssh,tcp,,2222,,22"
VBoxManage modifyvm "demo" --natpf1 "guesthttp,tcp,,8888,,80"
```


## Configure LAMP

zypper in apache2 php7 php7-mysql apache2-mod_php7 mariadb mariadb-tools
systemctl enable mysql
systemctl enable apache2

#Enable php module
a2enmod php7

## Check out testapp
zypper in git

cd /srv/www/htdocs 
git clone https://github.com/bystrobank/testapp.git

Open http://localhost:8888/testapp/web/documentList.php and see result
