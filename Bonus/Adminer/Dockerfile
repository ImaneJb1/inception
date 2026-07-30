FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql\
    wget

RUN mkdir -p var/www/adminer

RUN  wget https://www.adminer.org/latest.php \
    -O /var/www/adminer/index.php

COPY tools/start.sh /start.sh

RUN  chmod u+x /start.sh

EXPOSE 8080

ENTRYPOINT ["/start.sh"]

