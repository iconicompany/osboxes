set -e
cd /tmp
wget -O lens.deb "https://api.k8slens.dev/binaries/Lens-2022.12.221341-latest.amd64.deb"
sudo apt install ./lens.deb
rm -f lens.deb
