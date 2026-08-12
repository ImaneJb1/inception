NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_DIR = /home/$(USER)/data

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
	$(COMPOSE) down -v --rmi all --remove-orphans && sudo rm -rf $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress

re: fclean up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

wp:
	docker exec -it wordpress bash

db:
	docker exec -it mariadb bash

ng:
	docker exec -it nginx bash
