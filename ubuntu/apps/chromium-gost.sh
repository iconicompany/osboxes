#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
#wget -O chromuim-gost.deb https://github.com/deemru/Chromium-Gost/releases/download/111.0.5563.64/chromium-gost-111.0.5563.64-linux-amd64.deb
wget -O chromuim-gost.deb https://github.com/deemru/Chromium-Gost/releases/download/133.0.6943.98/chromium-gost-133.0.6943.98-linux-amd64.deb
sudo apt install ./chromuim-gost.deb
rm -f ./chromuim-gost.deb

