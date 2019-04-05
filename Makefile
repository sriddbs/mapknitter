export COMPOSE_HTTP_TIMEOUT=360

build:
	cp config/database.yml.example config/database.yml
	cp db/schema.rb.example db/schema.rb
	docker-compose build

deploy-container:
	docker-compose up -d
	docker-compose exec -T web bash -l -c "sleep 10 && rake db:setup && rake db:migrate && rake assets:precompile"

redeploy-container:
	docker-compose up --force-recreate -d
	docker-compose exec -T web bash -l -c "sleep 10 && rake db:migrate && rake assets:precompile"