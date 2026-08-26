set -e -v
VERSION=2.73.0
cd /tmp
curl -sSLO "https://tuf.werf.io/targets/releases/$VERSION/linux-amd64/bin/werf"
chmod +x werf
sudo mv werf /usr/local/bin
werf