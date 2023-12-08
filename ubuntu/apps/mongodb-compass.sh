set -e
cd /tmp
wget -O compass.deb https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb
sudo apt install ./compass.deb
rm -f compass.deb
