sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt install -y postgresql-16-pgvector
echo "CREATE EXTENSION vector;" | sudo -u postgres psql
