set -e -v
cd /tmp
curl -sSLO "https://tuf.werf.io/targets/releases/1.2.334/linux-amd64/bin/werf"
chmod +x werf
sudo mv werf /usr/local/bin
werf