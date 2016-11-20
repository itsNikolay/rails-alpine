# The RubyOnRails container

## Features
- Nokogiri
- Postgres
- Imagemagic
- Nodejs
- Tzdata

## How to work:

Under your rails app:

Dockerfile
```docker
FROM itsnikolay/rails-alpine

ENV APP_HOME /rails_app
ENV RAILS_ENV production

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
