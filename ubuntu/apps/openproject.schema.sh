echo -n "you are running $0 type yes to continue: "
read -r answer
[ "$answer" != "yes" ] && exit

PWD=`uuidgen`
sudo -u postgres psql << EOT
DROP DATABASE IF EXISTS openproject;
create database openproject;
CREATE USER openproject WITH PASSWORD '$PWD';
GRANT ALL PRIVILEGES ON DATABASE openproject to openproject;
ALTER USER openproject CREATEDB;
EOT

echo "Password for user 'openproject': '$PWD'"
