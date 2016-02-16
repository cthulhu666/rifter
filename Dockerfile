FROM ruby:2.2.3-slim

RUN apt-get update \
  && apt-get install -y git-core build-essential libsqlite3-dev \
  && apt-get clean

ADD Gemfile /app/
ADD Gemfile.lock /app/
ADD rifter.gemspec /app/
ADD lib/rifter/version.rb /app/lib/rifter/
WORKDIR /app
RUN bundle install 

CMD ./bin/console
