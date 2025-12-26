#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
VERSION=143.0.7499.169
#wget -O chromuim-gost.deb https://github.com/deemru/Chromium-Gost/releases/download/111.0.5563.64/chromium-gost-111.0.5563.64-linux-amd64.deb
wget -O chromuim-gost.deb https://github.com/deemru/Chromium-Gost/releases/download/${VERSION}/chromium-gost-${VERSION}-linux-amd64.deb
sudo apt install ./chromuim-gost.deb
rm -f ./chromuim-gost.deb

