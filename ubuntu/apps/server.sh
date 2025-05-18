set -e -v
./misc.sh
./nginx.sh
./certbot.sh
./squid.sh
./postgresql.sh
