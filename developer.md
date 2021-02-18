# Developer workstation

## Install OpenSuse 

Two options

1. Download [OpenSuse Leap ISO Image](https://software.opensuse.org/distributions/leap) and "burn" it to usb flash.
2. Try prepared [VirtualBox/VMVare image](virtualbox.md)

## Nodejs development

### Install nodejs

```
zypper install nodejs14
```

### Install vscode

From https://en.opensuse.org/Visual_Studio_Code

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code
```

## Python development
Install python, pandas, etc

```
zypper install python3-pandas python3-jupyter_notebook
```

## Java development

For java development install Java, Netbeans IDE

### Add repos for maven, netbeans

```bash
zypper ar "https://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_15.2/" "develtools"
zypper ar "http://download.opensuse.org/repositories/home:/Herbster0815/openSUSE_Leap_15.2/" "home:Herbster0815"
```

### Install packages

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

## PHP development

Setup netbeans as above (Java)

### Configure LAMP

LAMP = Linux + Apache + MySQL + PHP

```bash
zypper in apache2 php7 php7-mysql php7-curl php7-xsl xhtml-dtd mathml-dtd php7-tidy php7-mbstring apache2-mod_php7 php7-posix mariadb mariadb-tools
systemctl enable mysql
rcmysql start
systemctl enable apache2
a2enmod php7 # enable php module
rcapache2 start
```
