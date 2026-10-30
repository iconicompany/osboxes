#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
VERSION=$(curl -sI https://github.com/deemru/Chromium-Gost/releases/latest | grep -i ^location | sed 's|.*/tag/||;s/\r//')
wget -O chromium-gost.deb "https://github.com/deemru/Chromium-Gost/releases/download/${VERSION}/chromium-gost-${VERSION}-linux-amd64.deb"
sudo apt install ./chromium-gost.deb
rm -f ./chromium-gost.deb

