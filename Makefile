.PHONY: build run shell

build:
	docker compose build

run:
	docker compose up

shell:
	docker compose run --rm app bash
