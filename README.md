# Overview of selected stack
Provide a brief explanation of your chosen technology stack. While you don’t need to go into extensive detail, be prepared to justify your decisions.

## Framework
Ruby on Rails (v8.0)
This was chosen because it is the stack I have the most familiarity with and would accomplish the task with the least amount of overhead, onboarding, and code. Meanwhile, it offers flexibility to expand and scale, and offers easy deployment options.

## Database
sqlite
This comes out of the box with rails and requires no setup.
Upgrading to postgres is trivial and has been listed in future works.

## Frontend
Hotwire
https://www.hotrails.dev/
Comes out of the box as of rails 7.

## Authentication
Devise
https://github.com/heartcombo/devise

## Authorization
Cancancan
https://github.com/CanCanCommunity/cancancan

## Logging

## Dev requirements
* Docker
  To run the app locally, docker is required (or podman, though not tested).
  A Makefile has been provided for convenience.
  To run the necessary services, simply run:
  - `make build`
  - `make up`

# Architecture Overview
Highlight how the code is structured and any design patterns used.

# High Level Functionality Overview
List what features you have implemented and give an overview of user flow

# Future Works
* Use postgres rather than sqlite
  In production and at scale we would rather use a more robust database. This is trivial to switch to.
  - Uncomment the db section in the docker-compose.yml file
  - Replace sqlite3 in the Gemfile with pg
  - Update config/database.yml appropriately
