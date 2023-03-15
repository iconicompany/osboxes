set -e
cd /tmp
wget -O nomachine.deb https://download.nomachine.com/download/8.3/Linux/nomachine_8.3.1_1_amd64.deb
sudo apt install ./nomachine.deb
rm -f nomachine.deb
