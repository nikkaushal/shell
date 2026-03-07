dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql
dnf install -y postgresql16-server postgresql16
/usr/pgsql-16/bin/postgresql-16-setup initdb

sed -i "/listen_addresses/ c listen_addresses = '*'" /var/lib/pgsql/16/data/postgresql.conf
#sed -i '/replication/! s/peer/trust/' /var/lib/pgsql/16/data/pg_hba.conf
cp pg_hba.conf /var/lib/pgsql/16/data/pg_hba.conf

systemctl restart postgresql-16

sudo -u postgres /usr/pgsql-16/bin/psql -f schema.sql


