FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - - - - -
# install ruby+
# using FROM alpine and install only the ruby packages
# I need results in an image of ~102MB whereas
# using FROM ruby:alpine results in an image of ~162MB
# bundle install needs
#   tzdata for railties
#   zlib-dev for nokogiri
#   gcompat is also needed for nokogiri See https://stackoverflow.com/questions/37818831
#   libffi-dev is needed for sassc-rails
# - - - - - - - - - - - - - - - - -

RUN apk --update --upgrade --no-cache add \
    bash \
    curl \
    git \
    gcompat \
    libcurl \
    libexpat \
    libffi-dev \
    yaml-dev \
    nodejs \
    openssl \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-dev \
    tini \
    tzdata \
    zlib-dev

RUN apk add --upgrade libexpat=2.7.0-r0      # https://security.snyk.io/vuln/SNYK-ALPINE321-EXPAT-9459843
RUN apk add --upgrade c-ares=1.34.5-r0       # https://security.snyk.io/vuln/SNYK-ALPINE321-CARES-9680227
RUN apk add --upgrade sqlite=3.48.0-r2       # https://security.snyk.io/vuln/SNYK-ALPINE321-SQLITE-9712340
RUN apk add --upgrade sqlite-libs=3.48.0-r2  # https://security.snyk.io/vuln/SNYK-ALPINE321-SQLITE-9712340
RUN apk add --upgrade ruby=3.3.8-r0          # https://security.snyk.io/vuln/SNYK-ALPINE321-RUBY-9802138

WORKDIR /cyber-dojo
COPY source .

RUN apk --update --upgrade --no-cache add --virtual build-dependencies build-base \
  && echo "gem: --no-rdoc --no-ri" > ~/.gemrc \
  && bundle config --global silence_root_warning 1 \
  && bundle install \
  && apk del build-dependencies build-base \
  && rm -vrf /var/cache/apk/*

ARG COMMIT_SHA
ENV SHA=${COMMIT_SHA}
