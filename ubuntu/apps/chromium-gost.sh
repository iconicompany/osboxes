#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
wget -O chromuim-gost.deb https://github.com/deemru/Chromium-Gost/releases/download/111.0.5563.64/chromium-gost-111.0.5563.64-linux-amd64.deb
#102.0.5005.61/chromium-gost-102.0.5005.61-linux-amd64.deb
sudo apt install ./chromuim-gost.deb
rm -f ./chromuim-gost.deb

