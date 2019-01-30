start: up setup

prod: bg setup

setup:
	docker-compose run app bundle exec rake db:create decidim:upgrade db:migrate

upgrade:
	docker-compose run app bundle exec rake decidim:upgrade db:migrate

seed:
	docker-compose run -e SEED=true app bundle exec rake db:seed

admin:
	docker-compose run app rake admin:create

up:
	docker-compose up

down:
	docker-compose down

bg:
	docker-compose -f docker-compose.prod.yml up -d

release: clean build push

clean:
	rm -f ${PWD}/tmp/pids/server.pid

build:
	docker build -t osp-app . --tag opensourcepolitics/osp-app:latest --tag opensourcepolitics/osp-app:0.12.0

push:
	docker push opensourcepolitics/osp-app:latest
	docker push opensourcepolitics/osp-app:0.12.0