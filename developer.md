# Developer workstation

## Repos

Add repos for maven, netbeans

```bash
zypper ar "https://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_15.2/" "develtools"
zypper ar "http://download.opensuse.org/repositories/home:/Herbster0815/openSUSE_Leap_15.2/" "home:Herbster0815"
```

## Packages

```bash
sudo zypper in \
psi+ \
stunnel \
java-11-openjdk java-11-openjdk-src java-11-openjdk-javadoc java-11-openjdk-devel \
mysql-workbench \
git \
maven \
netbeans

```


## Configure LAMP

LAMP = Linux + Apache + MySQL + PHP

```bash
zypper in apache2 php7 php7-mysql php7-curl php7-xsl xhtml-dtd mathml-dtd php7-tidy apache2-mod_php7 php7-posix mariadb mariadb-tools
systemctl enable mysql
rcmysql start
systemctl enable apache2
a2enmod php7 # enable php module
rcapache2 start
```

## Setup node

```
zypper install nodejs10
```

## Setup python

```
zypper install python3-pandas python3-jupyter_notebook
```
