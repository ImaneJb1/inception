FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        netdata \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/netdata.conf /etc/netdata/netdata.conf

COPY ./tools/setup.sh /
RUN chmod u+x setup.sh
EXPOSE 19999

CMD ["./setup.sh"]