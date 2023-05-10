set -e
#wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo -e "\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main" | sudo tee  /etc/apt/sources.list.d/ubuntuzilla.list > /dev/null
sudo apt update
sudo apt install seamonkey-mozilla-build
