FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=ijoubair.42.fr"

COPY conf/default /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]