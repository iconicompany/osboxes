#https://ds-plugin.gosuslugi.ru/plugin/upload/Index.spr
set -e
cd /tmp
wget https://ds-plugin.gosuslugi.ru/plugin/upload/assets/distrib/IFCPlugin-x86_64.deb
sudo apt install ./IFCPlugin-x86_64.deb
rm -f IFCPlugin-x86_64.deb
