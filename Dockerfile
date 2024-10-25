FROM alpine:3.19.0
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

RUN apk --update --upgrade --no-cache add \
    bash \
    gcompat \
    git \
    libffi-dev \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-dev \
    tini \
    tzdata \
    zlib-dev

RUN apk add openssl=3.1.7-r0   # https://security.snyk.io/vuln/SNYK-ALPINE319-OPENSSL-7413527
RUN apk add libexpat=2.6.3-r0  # https://security.snyk.io/vuln/SNYK-ALPINE319-EXPAT-7908400
RUN apk add nodejs=20.15.1-r0  # https://security.snyk.io/vuln/SNYK-ALPINE319-NODEJS-6531253
RUN apk add c-ares=1.27.0-r0   # https://security.snyk.io/vuln/SNYK-ALPINE319-CARES-6483773
RUN apk add busybox=1.36.1-r19 # https://security.snyk.io/vuln/SNYK-ALPINE319-BUSYBOX-6928846
RUN apk add curl=8.9.1-r0      # https://security.snyk.io/vuln/SNYK-ALPINE319-CURL-7567377 \

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
