set -e
LATEST_VERSION=$(curl -s https://api.github.com/repos/xjasonlyu/tun2socks/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
curl -L -o - https://github.com/xjasonlyu/tun2socks/releases/download/$LATEST_VERSION/tun2socks-linux-amd64.zip | zcat > /tmp/tun2socks
chmod +x /tmp/tun2socks
sudo mv /tmp/tun2socks /usr/local/bin/tun2socks

tun2socks --help