set -e
cd /tmp
wget -O yandex.deb "https://browser.yandex.ru/download?os=linux&package=deb&x64=1"
sudo apt install ./yandex.deb
rm -f yandex.deb
