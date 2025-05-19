set -e -v
./misc.sh
./nginx.sh
./certbot.sh
./postgresql.sh
