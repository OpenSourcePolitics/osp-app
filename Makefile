branch=$(shell git rev-parse --abbrev-ref HEAD)

start: up

prod: bg setup

setup:
	docker-compose exec app bundle exec rake db:create decidim:upgrade db:migrate

upgrade:
	docker-compose exec app bundle exec rake decidim:upgrade db:migrate

seed:
	docker-compose exec -e SEED=true app bundle exec rake db:seed

admin:
	docker-compose exec app rake admin:create

up:
	docker-compose up

down:
	docker-compose down

bg:
	docker-compose -f docker-compose.prod.yml up -d

log: logs

logs:
	docker-compose logs

pull:
	docker-compose -f docker-compose.prod.yml pull

release: clean build push

clean:
	rm -f ${PWD}/tmp/pids/server.pid

build:
	docker build -t opensourcepolitics/osp-app:$(branch) .

push:
	docker push opensourcepolitics/osp-app:$(branch)