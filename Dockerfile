FROM alpine:3.20.3
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
    nodejs \
    openssl \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-dev \
    tini \
    tzdata \
    zlib-dev

WORKDIR /cyber-dojo
COPY Gemfile .

RUN apk --update --upgrade --no-cache add --virtual build-dependencies build-base \
  && echo "gem: --no-rdoc --no-ri" > ~/.gemrc \
  && bundle config --global silence_root_warning 1 \
  && bundle install \
  && apk del build-dependencies build-base \
  && rm -vrf /var/cache/apk/*

ARG COMMIT_SHA
ENV SHA=${COMMIT_SHA}
