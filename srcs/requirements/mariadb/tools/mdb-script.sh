ROOT_PASSWORD=$(cat "DB_ROOT_PASSWORD_FILE")
USER_PASSWORD=$(cat "DB_PASSWORD_FILE")

if [ ! -d "/var/lib/mysql/mysql"]; thenn