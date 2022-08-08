set -e
cd /tmp
# until there is no ppa for 22.04
wget -O whdd.deb https://ppa.launchpadcontent.net/whdd/stable/ubuntu/pool/main/w/whdd/whdd_3.0.0-0~20210122~ubuntu20.10.1_amd64.deb
sudo apt install ./whdd.deb
rm -f whdd.deb
