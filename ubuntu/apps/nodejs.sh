set -e
#cd /tmp
#curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
#sudo bash nodesource_setup.sh
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo tee /etc/apt/trusted.gpg.d/myrepo.asc
sudo sh -c "echo deb https://deb.nodesource.com/node_16.x jammy main \
> /etc/apt/sources.list.d/nodesource.list"
sudo apt-get update
sudo apt-get install nodejs


