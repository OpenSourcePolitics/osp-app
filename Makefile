start: up setup

prod: bg setup

setup:
	docker-compose run app bundle exec rake db:create decidim:upgrade db:migrate

upgrade:
	docker-compose run app bundle exec rake decidim:upgrade db:migrate

seed:
	docker-compose run -e SEED=true app bundle exec rake db:seed

admin:
	docker-compose run app echo 'Decidim::System::Admin.new(email: "system@example.org", password: "decidim123456", password_confirmation: "decidim123456)' | bundle exec rails c

up:
	docker-compose up

down:
	docker-compose down

bg:
	docker-compose up -d

release: build push

build:
	docker build -t osp-app . --tag opensourcepolitics/osp-app:latest --tag opensourcepolitics/osp-app:0.12.0

push:
	docker push opensourcepolitics/osp-app:latest
	docker push opensourcepolitics/osp-app:0.12.0