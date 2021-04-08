# Setup openSUSE Server

Setup openSUSE Server and deploy example packages

## Install OpenSuse 

Two options

1. Download [OpenSuse Leap ISO Image](https://software.opensuse.org/distributions/leap) and "burn" it to usb flash.
2. Try prepared [VirtualBox/VMVare image](virtualbox.md)

## Configure LAMP

LAMP = Linux + Apache + MySQL + PHP

```bash
zypper in apache2 php7 php7-mysql php7-curl php7-xsl apache2-mod_php7 mariadb mariadb-tools
systemctl enable mysql
rcmysql start
systemctl enable apache2
a2enmod php7 # enable php module
rcapache2 start
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
Add lines to `/etc/apache2/conf.d/jk.conf` or configured virtual host (preferable)
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

## Setup jenkins

Download jenkins
```
curl -o /srv/tomcat/webapps/jenkins.war http://mirrors.jenkins.io/war/latest/jenkins.war
```

Configure ajp proxy:
Add lines to `/etc/apache2/conf.d/jk.conf`
```
JkMount /jenkins ajp13
JkMount /jenkins/* ajp13
```

Open http://localhost:8888/jenkins/ and continue setup.

## Setup virtual hosts and ssl

### Install yast2-http-server and enable ssl and rewrite modules

```
zypper install yast2-http-server
a2enmod rewrite
a2enmod ssl
```

Run yast -> Network Services -> HTTP Server, configure virtual host.

### Setup certbot

```
zypper install python3-certbot python3-certbot-apache
```

Configure created virtual host
```
certbot --apache
```

And reaload http server configuration

```
rcapache2 reload
```
## Misc

### Track server configuration changes using svn repository

```
mkdir /var/svn
cd /var/svn
svnadmin create etc
cd /etc
svn co file:///var/svn/etc .
svn add apache2 [... other dirs you want to track...]
svn ci
```
