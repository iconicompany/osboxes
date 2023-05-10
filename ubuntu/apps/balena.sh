set -e
cd /tmp
wget -O balena.deb https://github.com/balena-io/etcher/releases/download/v1.18.8/balena-etcher_1.18.8_amd64.deb
sudo apt install ./balena.deb
rm ./balena.deb