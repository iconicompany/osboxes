set -e
cd /tmp
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
cd /opt
sudo tar -xf /tmp/google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
