set -e
LATEST_K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget -qO- https://github.com/derailed/k9s/releases/download/${LATEST_K9S_VERSION}/k9s_Linux_amd64.tar.gz | tar zxvf -  -C /tmp/
sudo mv /tmp/k9s /usr/local/bin
k9s version