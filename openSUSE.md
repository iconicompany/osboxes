# Setup openSUSE

## Setup virtualbox
Download [openSUSE 15.1 Leap Server Version](https://www.osboxes.org/opensuse/) image.

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


## Configure LAMP
```
zypper in apache2 php7 php7-mysql php7-curl php7-xsl apache2-mod_php7 mariadb mariadb-tools
systemctl enable mysql
rcmysql start
systemctl enable apache2
rcapache start
```
Enable php module
```
a2enmod php7
```

### Install git
```
zypper in git
```

### Deploy testapp (PHP)
```
cd /srv/www/htdocs 
git clone https://github.com/bystrobank/testapp.git
```

Create database schema:

```
cd testapp/tools/sql
mysql -uroot < testappdb.sql
mysql -uroot testapp < document.sql
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

As "root" user, create the `/etc/apache2/workers.properties` file with this content 
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

Create `/etc/apache2/conf.d/jk.conf` with this content

```
JkWorkersFile     /etc/apache2/workers.properties
JkShmFile     /var/log/apache2/mod_jk.shm
JkLogFile     /var/log/apache2/mod_jk.log

JkLogStampFormat "[%a %b %d %H:%M:%S %Y] "

# for correct URI encoding
JkOptions +ForwardURICompatUnparsed
```
### Fix tomcat package
Fix errors `java.lang.ClassNotFoundException: org.apache.commons.dbcp.BasicDataSourceFactory` and `org.apache.commons.logging.LogFactory`
```
cd /usr/share/java/tomcat
ln -s ../commons-logging.jar
sed -i 's/org.apache.commons.dbcp.BasicDataSourceFactory/org.apache.commons.dbcp2.BasicDataSourceFactory/' /usr/share/tomcat/conf/tomcat.conf
```

### Build fopservlet
```
cd $HOME
mkdir work
cd work
git clone https://github.com/bystrobank/fopservlet.git
cd fopservlet
mvn clean install
```
### Deploy fopservlet

```
cp $HOME/.m2/repository/org/apache/fop/fopservlet/1.0-SNAPSHOT/fopservlet-1.0-SNAPSHOT.war /srv/tomcat/webapps/fopservlet.war
```
Tomcat will unpack this war to `/srv/tomcat/webapps/fopservlet` directory.

Configure ajp proxy:
Add lines to `/etc/apache2/conf.d/jk.conf`
```
JkMount /fopservlet ajp13
JkMount /fopservlet/* ajp13
```

then restart/reload apache
```
service apache2 restart
```

Open http://localhost:8888/fopservlet/fopservlet?fo=helloworld.fo and see result

### Deploy eurofxref-daily (PHP)
```
cd /srv/www/htdocs 
git clone https://github.com/bystrobank/eurofxref-daily.git
```

Replace http://www.demo.ilb.ru/fopservlet/fopservlet in `web/eurofxref-daily.php` with http://localhost/fopservlet/fopservlet to use local fopservlet.

Open http://localhost:8888/eurofxref-daily/web/eurofxref-daily.php?format=pdf and see result

## Setup node

```
zypper install nodejs10
```

### Deploy static nextjs project

```
git clone https://github.com/ilb/nextjsproject.git
cd nextjsproject
npm install && npm run export
cp -r out/nextjsproject /srv/www/htdocs
cp -r out/_next /srv/www/htdocs/nextjsproject
```

Open http://localhost:8888/nextjsproject/home.html and see result
