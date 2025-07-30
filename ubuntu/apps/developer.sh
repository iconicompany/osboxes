set -e -v
./nodejs.sh
./bun.sh
./docker.sh
./werf.sh
./k9s.sh
