FROM ruby:2.4.4

MAINTAINER ihower <ihower@gmail.com>

WORKDIR /tmp
ADD Gemfile* ./

RUN apt-get update && \
    apt-get install -y build-essential libsqlite3-dev nodejs && \
    bundle install

ENV LC_ALL C.UTF-8
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV RAILS_SERVE_STATIC_FILES true

# openssl rand -hex 64
ENV SECRET_KEY_BASE e258ffed7ad281cdf36433dfcb8a3732939b89d71b4ef31857c42c71a056cd7b1a2bd62ef2964842960ff3f0613601f2546e6ba9027d66b39b52e40791027145

ENV APP_HOME /app
COPY . $APP_HOME
WORKDIR $APP_HOME

ENV RAILS_ENV=production \
    RACK_ENV=production

# RUN bundle exec rake db:setup # b/c we will upload db file to server manually
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["bundle", "exec", "puma", "-C", "config/puma.rb"]

## Local build & run & debug

# docker build . -t user-app
# docker run -v $(pwd)/db/userlist.sqlite3:/app/db/production.sqlite3 -p 4003:3000 user-app
# docker exec -it <CONTAINER ID> bash

## Production build & Deploy

# docker build . -t user-app
# cd ..
# docker save user-app -o user-app.tar
# scp user-app.tar acio:~/
# ssh acio
# docker load --input user-app.tar
# docker ps
# docker container stop <CONTAINER ID>
# docker run -v /home/deploy/db/user-list.sqlite3:/app/db/production.sqlite3 -p 4003:3000 -d --restart always user-app

