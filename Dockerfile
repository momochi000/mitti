FROM docker.io/ruby:3.4-slim

#RUN apt install build-essential libyaml-dev
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
