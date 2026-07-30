#!/bin/bash

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
USER_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
mariadbd-safe --user=mysql &
pid=$!

echo "Waiting for MariaDB..."
until mysqladmin ping --silent; do
    echo "Not ready..."
    sleep 1
done
echo "CREATING USERS";
# mysql ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
mysql -u root -p"${ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown
wait $pid

exec mariadbd-safe --user=mysql