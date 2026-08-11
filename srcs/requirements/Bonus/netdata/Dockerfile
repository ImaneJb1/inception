FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        netdata \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 19999

CMD ["netdata", "-D", "-s", "/host", "-p", "19999"]