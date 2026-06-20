#!/bin/bash

# Read the actual passwords from the secret file paths provided by our .env
ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
USER_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

# Ensure MariaDB system databases are initialized if they aren't already
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB temporarily in the background so we can configure it
mysqld_safe --user=mysql &
pid=$!

# Wait for MariaDB to wake up completely
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

# Run SQL commands using our safely extracted passwords
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Tell the temporary background MariaDB process to shut down cleanly
mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown
wait $pid

# Execute the main MariaDB server command in the foreground (PID 1)
exec mysqld_safe --user=mysql