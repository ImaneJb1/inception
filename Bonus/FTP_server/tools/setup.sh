#!/bin/bash

useradd -m ftpuser

echo "ftpuser:$(cat /run/secrets/ftp_user_password)" | chpasswd
chown ftpuser -R /var/www/html
exec vsftpd /etc/vsftpd.conf