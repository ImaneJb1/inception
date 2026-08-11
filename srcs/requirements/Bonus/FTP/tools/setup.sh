#!/bin/bash

useradd -m "$FTP_USER"

echo ""$FTP_USER":$(cat /run/secrets/ftp_user_password)" | chpasswd
chown "$FTP_USER" -R /var/www/html
exec vsftpd /etc/vsftpd.conf