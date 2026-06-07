FROM debian:latest

RUN  apt-get update &&  apt-get upgrade && apt-get install -y nginx

COPY  default /etc/nginx/latest-available/.

CMD ["nginx", "-g", "daemon off;"]
