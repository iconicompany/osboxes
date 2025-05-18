set -e -v
./step-cli.sh
./temporalio.sh
./nodejs.sh
./docker.sh
