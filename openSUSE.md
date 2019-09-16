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
```
zypper in apache2 php7 php7-mysql apache2-mod_php7 mariadb mariadb-tools
systemctl enable mysql
systemctl enable apache2
```
Enable php module
```
a2enmod php7
```

### Deploy testapp (PHP)
```
zypper in git
```

```
cd /srv/www/htdocs 
git clone https://github.com/bystrobank/testapp.git
```

Open http://localhost:8888/testapp/web/documentList.php and see result


## Configure tomcat

Install tomcat and maven
```
zypper ar "https://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_15.1/" "develtools"
zypper in tomcat maven apache2-mod_jk
a2enmod jk

systemctl enable tomcat
rctomcat start
```

As "root" user, create the "/etc/apache2/workers.properties" file with this content 
```
worker.list=ajp13
worker.ajp13.port=8009
worker.ajp13.host=localhost
worker.ajp13.type=ajp13
worker.ajp13.socket_keepalive=true
worker.ajp13.lbfactor=1
worker.ajp13.connection_pool_size=30
worker.ajp13.connect_timeout=5000
worker.ajp13.prepost_timeout=5000
```

Create /etc/apache2/conf.d/jk.conf with this content

```
JkWorkersFile     /etc/apache2/workers.properties
JkShmFile     /var/log/apache2/mod_jk.shm
JkLogFile     /var/log/apache2/mod_jk.log

JkLogStampFormat "[%a %b %d %H:%M:%S %Y] "

# for correct URI encoding
JkOptions +ForwardURICompatUnparsed

JkMount /fopservlet ajp13
JkMount /fopservlet/* ajp13
```
