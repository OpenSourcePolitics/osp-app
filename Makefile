migration:
	docker-compose run app bundle exec rails db:migrate

upgrade:
	docker-compose run app bundle exec rails decidim:upgrade

create:
	docker-compose run app bundle exec rails db:create

up:
	docker-compose up

staging:
	docker-compose -f docker-compose.staging.yml up

build:
	docker-compose build --compress --parallel

drop:
	docker-compose run app bundle exec rails db:drop

setup:
	docker-compose run app bundle exec rails db:create db:migrate

seed:
	docker-compose run app bundle exec rails db:seed

remove-stopped:
	docker-compose rm -f

precompile:
	docker-compose run app bundle exec rails assets:precompile

cache:
	docker-compose run app bundle exec rails tmp:cache:clear assets:clobber

ssh:
	docker-compose run app /bin/bash

local-bundle:
	bundle install

stop-all:
	 docker stop $$(docker ps -q -a)

prune:
	@make stop-all
	docker volume prune

bump:
	@make local-bundle
	@make build
	@make upgrade
	@make migration
	@make cache
	@make precompile
	@make remove-stopped
	@make staging

init:
	@make create
	@make migration
	@make upgrade
	@make seed
	@make remove-stopped

build-no-cache:
	docker-compose build --no-cache
