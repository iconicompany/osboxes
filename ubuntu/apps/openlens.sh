set -e
cd /tmp
wget -O openlens.deb "https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.2.5/OpenLens-6.2.5.amd64.deb"
sudo apt install ./openlens.deb
rm -f openlens.deb
