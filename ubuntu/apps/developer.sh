set -e -v
./temporalio.sh
./nodejs.sh
./bun.sh
./docker.sh
./werf.sh
