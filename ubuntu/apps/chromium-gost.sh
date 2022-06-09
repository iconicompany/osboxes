#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
wget https://github.com/deemru/Chromium-Gost/releases/download/102.0.5005.61/chromium-gost-102.0.5005.61-linux-amd64.deb
sudo apt install ./chromium-gost-102.0.5005.61-linux-amd64.deb
rm -f chromium-gost-102.0.5005.61-linux-amd64.deb
