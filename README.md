# Overview of selected stack
Provide a brief explanation of your chosen technology stack. While you don’t need to go into extensive detail, be prepared to justify your decisions.
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
