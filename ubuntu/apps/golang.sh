# https://linuxconfig.org/how-to-install-go-on-ubuntu-22-04-jammy-jellyfish-linux
#sudo apt install golang
cd /tmp
VERSION=1.24.3
wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz
echo Add "export PATH=\$PATH:/usr/local/go/bin" to $HOME/.profile or /etc/profile
