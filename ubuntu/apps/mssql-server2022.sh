set -e
curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/microsoft.gpg --import
sudo add-apt-repository -y "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

