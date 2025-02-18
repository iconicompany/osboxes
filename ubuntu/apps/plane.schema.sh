echo -n "you are running $0 type yes to continue: "
read -r answer
[ "$answer" != "yes" ] && exit

PWD=`uuidgen`
sudo -u postgres psql << EOT
DROP DATABASE IF EXISTS plane;
create database plane;
CREATE USER plane WITH PASSWORD '$PWD';
GRANT ALL PRIVILEGES ON DATABASE plane to plane;
ALTER USER plane CREATEDB;
EOT

echo "Password for user 'plane': '$PWD'"
