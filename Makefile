.PHONY: build run shell

build:
	docker compose build

up:
	docker compose up

shell:
	docker compose run --rm app bash
