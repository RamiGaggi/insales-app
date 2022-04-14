compose:
	@docker-compose up -d;

compose-build:
	@docker-compose build;

compose-logs:
	@docker-compose logs -f;

compose-down:
	@docker-compose down;

compose-clear:
	@docker-compose down -v --remove-orphans;

compose-stop:
	@docker-compose stop;

compose-shell:
	@docker-compose exec app sh;

compose-console:
	@docker-compose exec app bin/rails c;
