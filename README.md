# The lightweight RubyOnRails container

## Features
- Lightweight (just 86 MB of dependencies)
- The Fastest Build and Rebuild (~10 secs.)
- Configurable for any rails environments / docker environment
- Uses Postgresql by default (but you can add Mysql or anything you want)

## How to work:

Under your rails app:

Dockerfile
```docker
FROM itsnikolay/rails-alpine

ENV APP_HOME /rails_app
ENV RAILS_ENV production

# If you need to install imagemagick:
RUN apk add --update \
   imagemagick \
   && rm -rf /var/cache/apk/*

ADD . $APP_HOME
WORKDIR $APP_HOME
ENTRYPOINT docker-entrypoint.sh
RUN rm -rf .git
```

docker-entrypoint.sh
```shell
#!/bin/sh
set -e

bundle --deployment --path /bundle --without development test
bundle exec rake assets:precompile db:migrate --trace

exec "$@"
```

docker-compose.yml
```yml
version: '2'
services:
  rails_app:
    build: .
    command: bundle exec puma -C config/puma.rb
    volumes_from:
      - rails_busybox
  rails_busybox:
    image: busybox
    volumes:
      - /bundle
```

Run:
```shell
chmod +x docker-entrypoint.sh
docker-compose up
```
Enjoy!

TIP: Use `gem "therubyracer"` instead of `nodejs` to keep your container lite
