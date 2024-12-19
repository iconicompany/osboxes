# https://linuxconfig.org/how-to-install-go-on-ubuntu-22-04-jammy-jellyfish-linux
#sudo apt install golang
cd /tmp
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
rm go1.23.2.linux-amd64.tar.gz
echo Add "export PATH=\$PATH:/usr/local/go/bin" to $HOME/.profile or /etc/profile
