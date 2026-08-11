# User Documentation

## Overview

This project deploys a WordPress website using three Docker containers:

- NGINX (HTTPS reverse proxy)
- WordPress (PHP-FPM)
- MariaDB (database)

---

# Starting the Project

Start all services:

```bash
make
```

or

```bash
docker compose -f srcs/docker-compose.yml up -d
```

---

# Stopping the Project

Stop containers:

```bash
make down
```

Remove containers:

```bash
make clean
```

Remove everything:

```bash
make fclean
```

---

# Accessing the Website

Open:

```
https://<your-domain>
```

Example:

```
https://ijoubair.42.fr
```

Because HTTPS is self-signed, your browser may display a warning. Accept the warning to continue.

---

# Accessing WordPress Admin

Open:

```
https://<your-domain>/wp-admin
```

Login using the administrator account created during installation.

---

# Credentials

Passwords are stored as Docker secrets.

Example:

```
secrets/
├── db_password.txt
├── db_root_password.txt
├── wp_admin_password.txt
└── wp_user_password.txt
```

Usernames and non-sensitive configuration are stored inside:

```
srcs/.env
```

---

# Checking the Services

List running containers:

```bash
docker ps
```

Expected containers:

- nginx
- wordpress
- mariadb

---

View logs:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

---

Check Docker network:

```bash
docker network ls
```

---

Check Docker volumes:

```bash
docker volume ls
```

---

Verify HTTPS

Visit:

```
https://<your-domain>
```

The WordPress homepage should appear.