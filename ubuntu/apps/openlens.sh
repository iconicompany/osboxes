set -e
cd /tmp
wget -O openlens.deb "https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.5.2-366/OpenLens-6.5.2-366.amd64.deb"
sudo apt install ./openlens.deb
rm -f openlens.deb
