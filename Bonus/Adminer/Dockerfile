FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql\
    wget

RUN mkdir -p var/www/adminer

RUN RUN wget https://github.com/vrana/adminer/releases/latest/download/adminer.php \
    -O /var/www/adminer/index.php
COPY tools/start.sh /start.sh

