#!/bin/bash

# Extract passwords from our secure secret files
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Navigate to the folder where our website files live
cd /var/www/html

# Download WordPress if it isn't already there
if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    # Create the wp-config.php file linking it to MariaDB
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root

    # Install WordPress and set up the Administrator account
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    # Create the second mandatory regular user account
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
fi

# Ensure PHP-FPM listens on port 9000 instead of a local file socket
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf

# Ensure the php-fpm runtime folder exists so it can start up smoothly
mkdir -p /run/php

# Start PHP-FPM in the foreground so it remains active as PID 1
exec php-fpm8.2 -F