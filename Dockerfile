FROM ruby:2.3-alpine
RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  imagemagick-dev \
  nodejs \
  libmagic \
  file-dev \
  sqlite-dev \
  ruby-tzinfo \
  && rm -rf /var/cache/apk/*

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri --use-system-libraries
