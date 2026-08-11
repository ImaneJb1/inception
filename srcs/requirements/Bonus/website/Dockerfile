FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y python3 &&\
    rm -rf /var/lib/apt/lists/*

COPY ./tools/index.html /var/www/html/index.html

ENTRYPOINT ["python3", "-m", "http.server", "8080", "--directory", "/var/www/html"]