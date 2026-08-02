FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y vsftpd

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/setup.sh /setup.sh

RUN chmod u+x /setup.sh

RUN mkdir -p /var/www/html
RUN mkdir -p /var/run/vsftpd/empty

ENTRYPOINT ["/setup.sh"]
