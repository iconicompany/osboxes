set -e
wget -qO- "https://temporal.download/cli/archive/latest?platform=linux&arch=amd64" | tar zxvf -  -C /tmp/
sudo mv -f /tmp/temporal /usr/local/bin
temporal -v
