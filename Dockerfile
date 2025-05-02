FROM docker.io/ruby:3.4-slim

RUN apt-get update
RUN apt install -y build-essential libyaml-dev
WORKDIR /app

COPY mitti/Gemfile .
COPY mitti/Gemfile.lock .

RUN bundle install

COPY . .
