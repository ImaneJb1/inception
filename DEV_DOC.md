# Developer Documentation

## Prerequisites

Install:

- Docker
- Docker Compose
- GNU Make

Verify installation:

```bash
docker --version
docker compose version
make --version
```

---

# Repository Structure

```
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
└── srcs/
```

---

# Configuration Files

The project uses:

```
srcs/.env
```

for configuration variables.

Example:

- DOMAIN_NAME
- DB_NAME
- DB_USER
- WP_ADMIN_USER
- WP_USER

Passwords are stored inside:

```
secrets/
```

---

# Building the Project

Build all images:

```bash
make
```

or

```bash
docker compose -f srcs/docker-compose.yml up --build -d
```

---

# Rebuilding

```bash
make re
```

---

# Managing Containers

Start:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

Restart:

```bash
docker compose restart
```

List:

```bash
docker ps
```

Enter a container:

```bash
docker exec -it wordpress bash
```

---

# Managing Volumes

List volumes:

```bash
docker volume ls
```

Inspect:

```bash
docker volume inspect <volume>
```

Remove unused volumes:

```bash
docker volume prune
```

---

# Persistent Data

The project stores data inside Docker volumes.

MariaDB volume stores:

- databases
- tables
- users

WordPress volume stores:

- uploads
- themes
- plugins
- configuration

Containers can be deleted without losing this data because the volumes remain on the host.

---

# Useful Commands

View logs:

```bash
docker logs nginx
```

Inspect network:

```bash
docker network inspect inception_network
```

Inspect container:

```bash
docker inspect wordpress
```

---

# Development Workflow

1. Modify configuration.
2. Rebuild images if necessary.
3. Restart the affected service.
4. Check logs.
5. Verify the website.