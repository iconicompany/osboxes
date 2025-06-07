set -e
cd /tmp
wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20250524170830.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb
rm minio.deb
curl -o mc-minio https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc-minio
sudo mv mc-minio /usr/local/bin
