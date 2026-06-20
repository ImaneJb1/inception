FROM debian:latest

RUN apt-get update && apt-get upgrade && apt-get install -y mariadb-server

COPY ./conf/50-server.cnf  /etc/mysql/mariadb.conf.d/

CMD ["mariadbd-safe"]

