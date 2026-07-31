FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/50-server.cnf  /etc/mysql/mariadb.conf.d/

COPY ./tools/mdb-script.sh /usr/local/bin/mdb-script.sh

RUN mkdir -p /var/lib/mysql/

RUN chmod u+x /usr/local/bin/mdb-script.sh

ENTRYPOINT ["/usr/local/bin/mdb-script.sh"]

