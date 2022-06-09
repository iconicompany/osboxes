#https://dev.rutoken.ru/pages/viewpage.action?pageId=72451917
set -e
sudo apt-get install libccid pcscd libpcsclite1 pcscd pcsc-tools opensc
cd /tmp
wget https://download.rutoken.ru/Rutoken/PKCS11Lib/2.3.3.0/Linux/x64/librtpkcs11ecp_2.3.3.0-1_amd64.deb
sudo apt install ./librtpkcs11ecp_2.3.3.0-1_amd64.deb
rm -f librtpkcs11ecp_2.3.3.0-1_amd64.deb