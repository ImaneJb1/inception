NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_DIR = /home/ijoubair/data

all: up

up:
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --remove-orphans

fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans

re: fclean up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

wp:
	docker exec -it wordpress bash

db:
	docker exec -it mariadb bash