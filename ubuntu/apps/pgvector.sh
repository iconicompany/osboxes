sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt install postgresql-14-pgvector
echo "CREATE EXTENSION vector;" | sudo -u postgres psql
