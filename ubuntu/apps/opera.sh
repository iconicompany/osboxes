#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
cd /tmp
curl -Lo opera.deb "https://download.opera.com/download/get/?id=61379&location=424&nothanks=yes&sub=marine&utm_tryagain=yes"
sudo apt install ./opera.deb
rm -f ./opera.deb

