set -e
LATEST_K3S_VERSION=$(curl -s https://api.github.com/repos/k3s-io/k3s/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
TMPDIR=`mktemp -d`
cd  ${TMPDIR}
curl -Lo k3s https://github.com/k3s-io/k3s/releases/download/${LATEST_K3S_VERSION}/k3s
chmod a+x k3s
sudo mkdir -p /usr/local/bin
sudo mv -f k3s /usr/local/bin/k3s
sudo ln -sf k3s /usr/local/bin/kubectl

