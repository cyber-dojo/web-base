FROM alpine:latest
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - - - - -
# install ruby+
# using FROM alpine and install only the ruby packages
# I need results in an image of ~102MB whereas
# using FROM ruby:alpine results in an image of ~162MB
# bundle install needs
#   tzdata for railties
#   zlib-dev for nokogiri
# - - - - - - - - - - - - - - - - -

RUN apk --update --upgrade --no-cache add \
    bash \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-dev \
    tzdata \
    zlib-dev

# - - - - - - - - - - - - - - - - -
# install gems
# - - - - - - - - - - - - - - - - -

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
