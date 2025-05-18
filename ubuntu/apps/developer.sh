set -e -v
./step-cli.sh
./temporalio.sh
./nodejs.sh
./bun.sh
./docker.sh
