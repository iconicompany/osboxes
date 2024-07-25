VER=2024.1.5
PKG=roadrunner-${VER}-linux-amd64.deb
cd /tmp
wget https://github.com/roadrunner-server/roadrunner/releases/download/v${VER}/${PKG}
sudo dpkg -i ${PKG}
