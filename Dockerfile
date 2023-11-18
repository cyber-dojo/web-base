ARG BASE_IMAGE=alpine:3.18.4
FROM ${BASE_IMAGE}
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
#   curl is needed to move past snyk CVE
#   libffi-dev is needed for sassc-rails
# - - - - - - - - - - - - - - - - -

RUN apk add libcurl=8.4.0-r0        # https://security.snyk.io/vuln/SNYK-ALPINE318-CURL-5958913#
RUN apk add nghttp2-libs=1.57.0-r0  # https://security.snyk.io/vuln/SNYK-ALPINE318-NGHTTP2-5954768
RUN apk add libcrypto3=3.1.4-r1     # https://security.snyk.io/vuln/SNYK-ALPINE318-OPENSSL-6055795

RUN apk --update --upgrade --no-cache add \
    bash \
    git \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-dev \
    tini \
    tzdata \
    zlib-dev \
    gcompat \
    curl \
    libffi-dev

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
ENV COMMIT_SHA=${COMMIT_SHA}

# ARGs are reset after FROM See https://github.com/moby/moby/issues/34129
ARG BASE_IMAGE
ENV BASE_IMAGE=${BASE_IMAGE}
