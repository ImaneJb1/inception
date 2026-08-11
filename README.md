*This project has been created as part of the 42 curriculum by ijoubair.*

# Inception

## Description

**Inception** is a system administration project from the 42 curriculum that introduces containerization using Docker. The objective is to build a secure, reproducible, and isolated web infrastructure composed of multiple services communicating through Docker networks.

Unlike traditional application deployment, each service runs inside its own container and is built from a custom Dockerfile instead of using pre-built images. The infrastructure is orchestrated using Docker Compose and follows the project's constraints regarding security, networking, persistence, and service isolation.

### Project Goal

The goal of this project is to understand how modern applications are deployed by learning to:

- Build custom Docker images
- Configure multiple services to work together
- Manage persistent data
- Secure communications using HTTPS
- Automate deployment with Docker Compose
- Understand the advantages of containerization over traditional virtual machines

### Services

The mandatory project consists of three containers:

| Service | Purpose |
|---------|---------|
| **NGINX** | HTTPS server using TLS 1.2/1.3 |
| **WordPress + PHP-FPM** | Hosts the WordPress application |
| **MariaDB** | Stores the WordPress database |

These containers communicate through a private Docker network while storing persistent data inside Docker volumes.

---

# Project Design

## Why Docker?

Docker allows applications and their dependencies to be packaged into lightweight containers. Every container runs in an isolated environment while sharing the host operating system kernel.

Benefits include:

- Reproducible environments
- Fast deployment
- Service isolation
- Portability
- Simplified dependency management

---

## Project Architecture

```
                HTTPS (443)

                 +---------+
                 | NGINX   |
                 +----+----+
                      |
                FastCGI
                      |
             +--------+--------+
             | WordPress       |
             | PHP-FPM         |
             +--------+--------+
                      |
              Docker Network
                      |
             +--------+--------+
             | MariaDB         |
             +-----------------+

Persistent Volumes

- WordPress files
- MariaDB database
```

---

# Technical Choices

## Base Image

Debian was chosen because:

- Stable package repository
- Long-term support
- Well documented
- Familiar Linux environment

---

## Reverse Proxy

NGINX handles:

- HTTPS encryption
- SSL certificates
- Client requests
- Communication with PHP-FPM

---

## Database

MariaDB is used because it is fully compatible with MySQL while remaining lightweight and open source.

---

## Docker Compose

Docker Compose automates the deployment by:

- Building images
- Creating networks
- Creating volumes
- Starting containers
- Managing dependencies

---

# Comparisons

## Virtual Machines vs Docker
---------------------------------------------------------------------------------------------
|               Virtual Machine                  |                  Docker                  |
|------------------------------------------------|------------------------------------------|
| Includes a full guest operating system         | Shares the host kernel                   |
| Uses more RAM and disk space                   | Lightweight                              |
| Slower startup                                 | Starts in seconds                        |
| Strong hardware-level isolation                | Process-level isolation                  |
| Better for running different operating systems | Best for microservices and applications  |
---------------------------------------------------------------------------------------------
For this project Docker is preferred because containers are faster, lighter, and easier to manage.

---

## Secrets vs Environment Variables

### Environment Variables

Environment variables store configuration values such as:

- Database name
- Database host
- Username
- Domain name

Advantages:

- Easy to configure
- Easy to modify
- Convenient for non-sensitive information

Disadvantages:

- Visible through Docker inspection
- Not suitable for passwords

---

### Docker Secrets

Secrets store sensitive information such as:

- Database passwords
- WordPress administrator password

Advantages:

- Stored separately from configuration
- Mounted as files
- More secure than environment variables

---

## Docker Network vs Host Network

### Docker Bridge Network

- Containers communicate privately.
- Internal DNS resolves service names.
- Better isolation.
- Recommended for multi-container applications.

### Host Network

- Container shares the host network.
- No network isolation.
- Better performance.
- Less secure.

This project uses a bridge network because services only need to communicate with each other.

---

## Docker Volumes vs Bind Mounts

### Docker Volumes

Advantages:

- Managed by Docker
- Portable
- Persistent
- Recommended for databases

Used in this project for:

- MariaDB data
- WordPress files

---

### Bind Mounts

Advantages:

- Direct access from host
- Useful during development

Disadvantages:

- Depends on host filesystem
- Less portable

Docker volumes are preferred because they provide better portability and persistence.

---

# Instructions

## Requirements

- Docker
- Docker Compose
- Make

---

## Clone

```bash
git clone <repository_url>
cd inception
```

---

## Build

```bash
make
```

---

## Stop

```bash
make down
```

---

## Clean

```bash
make clean
```

---

## Remove everything

```bash
make fclean
```

---

## Rebuild

```bash
make re
```

---

## Useful Commands

View running containers:

```bash
docker ps
```

View logs:

```bash
docker logs <container>
```

Open a shell:

```bash
docker exec -it <container> bash
```

---

# Resources

## Docker

- https://docs.docker.com/
- https://docs.docker.com/compose/

## NGINX

- https://nginx.org/en/docs/

## MariaDB

- https://mariadb.com/kb/en/

## WordPress

- https://developer.wordpress.org/

## PHP-FPM

- https://www.php.net/manual/en/install.fpm.php

## OpenSSL

- https://www.openssl.org/docs/

## AI Usage

Artificial intelligence was used as a learning assistant throughout the project.

It was mainly used to:

- Clarify Docker concepts.
- Understand networking, volumes, and container isolation.
- Explain NGINX and PHP-FPM configuration.
- Review shell scripts.
- Improve the project documentation.

All architecture decisions, Dockerfiles, configuration files, scripts, debugging, implementation, and testing were completed manually. AI was used only to explain concepts, answer questions, and assist with writing documentation.

---

# Learning Outcomes

This project provided practical experience with:

- Docker
- Docker Compose
- Linux system administration
- Container networking
- Persistent storage
- HTTPS and TLS
- MariaDB
- WordPress deployment
- Infrastructure automation