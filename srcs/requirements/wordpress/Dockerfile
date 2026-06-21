FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \ 
    php8.4-fpm \
    php-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp   

RUN mkdir -p /var/www/html

COPY tools/wp-script.sh /usr/local/bin/wp-script.sh
RUN chmod +x /usr/local/bin/wp-script.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-script.sh"]