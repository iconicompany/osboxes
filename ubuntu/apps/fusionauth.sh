set -e
cd /tmp
VERSION=$(curl -fsSL https://license.fusionauth.io/api/latest-version) && \
curl -fsSL https://files.fusionauth.io/products/fusionauth/${VERSION}/fusionauth-app_${VERSION}-1_all.deb > fusionauth-app_${VERSION}-1_all.deb && \
sudo dpkg -i fusionauth-app_${VERSION}-1_all.deb && \
sudo systemctl start fusionauth-app

#cd /tmp
#wget -c https://files.fusionauth.io/products/fusionauth/1.46.0/fusionauth-app_1.46.0-1_all.deb
#wget -c https://files.fusionauth.io/products/fusionauth/1.46.0/fusionauth-search_1.46.0-1_all.deb
#sudo dpkg -i fusionauth-app_1.46.0-1_all.deb
#sudo dpkg -i fusionauth-search_1.46.0-1_all.deb

#sudo service fusionauth-search start
#sudo service fusionauth-app start
