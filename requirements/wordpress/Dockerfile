FROM debian:latest

RUN apt-get update && apt-get install -y php-fpm

COPY www.conf /etc/php/8.4/fpm/pool.d/.

CMD ["php-fpm8.4", "-F"]