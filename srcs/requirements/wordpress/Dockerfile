FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y php8.4-fpm wget tar

RUN mkdir -p /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress/* /var/www/html \
    && rm -rf latest.tar.gz wordpress

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/.


CMD ["php-fpm8.4", "-F"]