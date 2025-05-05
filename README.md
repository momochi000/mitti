# Intro
Welcome to Mitti! A property risk evaluator and mitigation finder.

# Overview of selected stack
Provide a brief explanation of your chosen technology stack. While you don’t need to go into extensive detail, be prepared to justify your decisions.

## Framework
Ruby on Rails (v8.0)

This was chosen because it is the stack I have the most familiarity with and
would accomplish the task with the least amount of overhead, onboarding, and
code. Meanwhile, it offers flexibility to expand and scale, and offers easy
deployment options. Other engineers who onboard to the codebase need only
understand standard rails practices.

## Database
Sqlite
This comes out of the box with Rails and requires no setup.
Upgrading to postgres is trivial and has been listed in future works.

## Frontend
Hotwire
https://www.hotrails.dev/
Comes out of the box as of rails 7. This provides responsive UI behavior
without requiring the use of javascript.

## Authentication & Authorization
Devise
https://github.com/heartcombo/devise

Cancancan
https://github.com/CanCanCommunity/cancancan

## Logging
Standard rails logger to STDOUT

## Dev requirements
* Docker
  To run the app locally, docker is required (or podman, though not tested).
  A Makefile has been provided for convenience.
  To run the necessary services, simply run:
  - `make build`
  - `make up`

In order to make calls to openai, you will need to provide an openai api
key. It will be read from an environment variable.  For convenience,
create a `.env` file in the project root and add your
`OPENAI_API_KEY='...'` to it.

# Architecture Overview
The code is structured following Rails standards.
Models, views, controllers, and routes all reside in their default locations.
This means the app follows the conventional rails MVC pattern.

The only deviation from standard is a "app/services" folder where the rule engine
application code lives. Additionally, there is a "app/llm" folder where I've placed
the tool definitions for the llm to use.

## Auth
Users are all stored in the users table, and they are divided by type. Rails
provides a feature called single table inheritance (STI), which allows a single
database table to store an inheritance tree of model types. In this case there
is a base user type (User), an underwriter type (Users::Underwriter), an
applied scientist type (Users::AppliedScientist), and an admin type
(Users::Admin). I chose to nest the user types under a 'users' folder (and
therefore, module in ruby) because in my experience, the "app/models" folder
becomes very crowded as a rails app ages, making it very difficult to navigate
and understand. It is vital to keep this folder organized. This introduced some
tradeoffs with the User models configuration but I believe the end result is
worth it.

## Gems (3rd party dependencies) and usage/purpose
See the Gemfile for the full list and Gemfile.lock for full dependencies

* Devise
  User authentication. It provides functionality to log users in and out,
  tracking their user in the session. It encrypts users secrets. It provides
  convenience functions to check that a user is logged in and prevent access to
  non-logged-in users.
* Cancancan
  User authorization. It allows for central definition of who is able to do
  what in the app. It then allows one to utilize those definitions to restrict
  access to various pages, controls, or whatever to those who have the defined
  permissions
* Langchainrb
  Provides convenient interface to language models.  Allows for easy changing
  out to other models and unified access to their responses.
* Ruby-openai
  To connect with OpenAI's api.
* Paper_trail
  Object versioning. A model (table) tagged with has_paper_trail will be
  tracked such that if a row in the database is updated or deleted, we will
  have access to the history of changes. This powers the historical
  rule-running feature.
* Parallel
  Gem which provides an api for concurrency controls
* Factory_bot_rails
  A convenient method of creating and instantiating model objects and
  relationships in various states. Useful for testing
* Faker
  Convenient random data generator
* Rspec
  Testing framework
* Pry
  Debugging tool

Other gems come standard with rails

## Frontend/UI
The app uses Rails HTML views boosted by Turbo and Hotwire (combined known as
turbo-rails) to send HTML over the wire and provide a responsive
single-page-app-like experience without the need for custom javascript. Pages
do not need full reload when navigating, and sections of the page can be
updated independently. This removes dependency on react/vue/svelte/etc.

Most of the benefits come out of the box without thinking about it, but i
utilized turbo specifically in a few places so that the UX would be convenient
for users: when evaluating rules, and when testing rules. In this way, the
results could appear on the page without navigating away or losing what the
user had entered into a form.

## Brief explanation of Rails standards and important locations
Models represent the domain objects, provide the ORM for convenient database
access, and map 1-1 with database tables.

Controllers contain actions which represent endpoints in the API.

Views contain the UI and UI elements. They are often returned from controller
actions and sent to the browser.

Routes define the API structure. They map urls to controller actions and
provide convenient names and helper functions.

The db folder contains the database schema and migrations. Migrations are
incremental changes to the schema so that it can be properly versioned accross
all environments

## API design
RESTful CRUD operations for Observations, Properties, and Rules.

e.g.:
GET /rules (list rules)
GET /rules/:id (show a particular rule)
DELETE /rules/:id (destroy a particular rule)
and so on.

POST /observations/:observation_id/run
An observation can be _run_, which evaluates all rules against it.

PUT/PATCH /test_rule
A rule can be tested, where an observation can be provided in order to check
how the rule behaves against it, before creating the rule, or while editing
one.

There are also dashboard endpoints for each of the user types, and endpoints to
log users in and out.

## Database structure
* users
* properties
  - address
* rules
  - name
  - written_rule
  - functional_rule
  - example_mitigation
  - user_id (creator)
* observations
  - content (json blob)
  - property_id
* versions
  this table is required for paper_trail, a versioning tool

# High Level Functionality Overview
## User login and controls
The app contains 3 different user types, each of which have access to a
different subset of functionality. Users must log in to the app to do anything.

Underwriter users can create properties and observations against those
properties, as well as run vulnerability rules against those observations. They
can also view rules but cannot add, modify, or remove them.

Applied scientist users can create and manage rules as well as observations.
They can test rules before creating them, or while editing them.

Admin users have access to everything

## Vulnerability evaluation
The main meat of the app is to evaluate a property against the vulnerability
rules that have been defined by the applied scientist users. This calls the
language model and prompts it to examine a set of observations about a property
against each of the rules in the database.

Observations are a json of facts about a property, including details around
construction materials, quality, the nearby environment, and so on. A
vulnerability rule relates to a specific feature of a property, for exmaple,
windows, the roof, the foundation, and so on. Each rule is evaluated against a
set of observations.

First, the language model determines if the property is vulnerable to the rule
or not. It may already satisfy the needs of the rule, or it may not be relevant
to the rule (e.g. fireplace safety when the property has no fireplace). If the
property is determined to be vulnerable, then it will try to decide what
mitigations, if any, may be taken at the property in order to harden it against
the vulnerability.

It accomplishes both of these through tool usage to ensure that the return
value is in a structured format and reduce randomness in output (hallucinations
or pontificating). It applies the rules in parallel to reduce latency for the user.

Additionally, an observation may be evaluated against all the current rules, OR
the rules which existed at the time the observation was made. This is
accomplished through the paper_trail gem, which keeps track of changes to the
data (in this case, rules). If a rule is updated, there is a record of when it
was changed. An observation has an "observed_at" timestamp. By looking at the
state of the rule data at that timestamp, we load the rules as they were at the
given time.

# Future Works
* Use postgres rather than sqlite
  In production and at scale we would rather use a more robust database. This is trivial to switch to.
  - Uncomment the db section in the docker-compose.yml file
  - Replace sqlite3 in the Gemfile with pg
  - Update config/database.yml appropriately
* Make existing tests pass
* Add more tests
* Set up and utilize eval framework
* Create table/model for vulnerabilities
  to store the output from rule runs
* More robust logging and observability
* Add ability to onboard users
  Currently I can only create users via the console
* Create mitigation model
  to store output from rule runs. This will track what mitigations have been "assigned" to a property
  which they could then complete, thereby tracking their improvements.
* Styling. It's got no css currently
* Allow markdown or rich text input for rules
  As these feed prompts, LLMs do respond to things like headers and emphasis so it could increase the accuracy of rules.
  It also allows underwriters to express their intent more deeply than plain text.
* Revisit UX
  More controls on the respective user dashboards might make sense
