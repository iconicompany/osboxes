set -e
cd /tmp
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt install ./viber.deb
rm -f viber.deb
# https://askubuntu.com/questions/1403319/viber-no-connection-on-ubuntu-22-04-even-i-have-an-internet
wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1l-1ubuntu1.3_amd64.deb
sudo dpkg -i libssl1.1_1.1.1l-1ubuntu1.3_amd64.deb
rm -f libssl1.1_1.1.1l-1ubuntu1.3_amd64.deb
sudo sed -i 's^Exec=/opt/viber/Viber^Exec=LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libssl.so /opt/viber/Viber^' /usr/share/applications/viber.desktop 
