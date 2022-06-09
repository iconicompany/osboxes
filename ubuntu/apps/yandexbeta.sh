set -e
cd /tmp
wget -O yandex.deb "https://browser.yandex.ru/download/?banerid=6301000000&zih=1&beta=1&os=linux&x64=1&package=deb&full=1"
sudo apt install ./yandex.deb
rm -f yandex.deb
