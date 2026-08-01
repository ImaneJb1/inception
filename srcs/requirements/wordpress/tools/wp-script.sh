#!/bin/bash

# Extract passwords from our secure secret files
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Navigate to the folder where our website files live
cd /var/www/html

# Download WordPress if needed
if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
fi

# Wait until MariaDB is ready
until wp db check --allow-root >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done
echo "mariadb is ready"
# Install WordPress if it's not installed
if ! wp core is-installed --allow-root; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
fi

# -------------------
# Redis configuration
# -------------------
wp config has WP_REDIS_HOST --allow-root || \
    wp config set WP_REDIS_HOST redis --allow-root

wp config has WP_REDIS_PORT --allow-root || \
    wp config set WP_REDIS_PORT 6379 --raw --allow-root

# Install plugin if missing
if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --activate --allow-root
    # Otherwise activate it if it's installed but inactive
elif ! wp plugin is-active redis-cache --allow-root; then
    wp plugin activate redis-cache --allow-root
fi


# Enable object cache
wp redis enable --allow-root || true


# Ensure PHP-FPM listens on port 9000 instead of a local file socket
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf

# Ensure the php-fpm runtime folder exists so it can start up smoothly
mkdir -p /run/php

# Start PHP-FPM in the foreground so it remains active as PID 1
exec php-fpm8.2 -F
