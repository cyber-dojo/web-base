
[![CircleCI](https://circleci.com/gh/cyber-dojo/web-base.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web-base)

- The base image for the main [web](https://github.com/cyber-dojo/web)-server
for [cyber-dojo.org](http://cyber-dojo.org).
- Helps speed up builds.

- - - -

# build the image
```text
Building web-base
Step 1/6 : FROM alpine:latest
latest: Pulling from library/alpine


Digest: sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6

Status: Downloaded newer image for alpine:latest

 ---> 055936d39205
Step 2/6 : LABEL maintainer jon@jaggersoft.com
 ---> Running in f1cad8ae135e
 ---> a5f6daec3b10
Removing intermediate container f1cad8ae135e
Step 3/6 : RUN apk --update --upgrade --no-cache add     bash     libffi-dev     ruby     ruby-bigdecimal     ruby-bundler     ruby-dev     tzdata     zlib-dev
 ---> Running in ccd03143d53f
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/25) Installing ncurses-terminfo-base (6.1_p20190105-r0)
(2/25) Installing ncurses-terminfo (6.1_p20190105-r0)
(3/25) Installing ncurses-libs (6.1_p20190105-r0)
(4/25) Installing readline (7.0.003-r1)
(5/25) Installing bash (4.4.19-r1)
Executing bash-4.4.19-r1.post-install
(6/25) Installing linux-headers (4.18.13-r1)
(7/25) Installing libffi (3.2.1-r6)
(8/25) Installing pkgconf (1.6.0-r0)
(9/25) Installing libffi-dev (3.2.1-r6)
(10/25) Installing ca-certificates (20190108-r0)
(11/25) Installing gmp (6.1.2-r1)
(12/25) Installing yaml (0.2.1-r0)
(13/25) Installing ruby-libs (2.5.5-r0)
(14/25) Installing ruby (2.5.5-r0)
(15/25) Installing ruby-bigdecimal (2.5.5-r0)
(16/25) Installing ruby-etc (2.5.5-r0)
(17/25) Installing ruby-io-console (2.5.5-r0)
(18/25) Installing ruby-bundler (1.17.1-r0)
(19/25) Installing libgcc (8.3.0-r0)
(20/25) Installing libstdc++ (8.3.0-r0)
(21/25) Installing libgmpxx (6.1.2-r1)
(22/25) Installing gmp-dev (6.1.2-r1)
(23/25) Installing ruby-dev (2.5.5-r0)
(24/25) Installing tzdata (2019a-r0)
(25/25) Installing zlib-dev (1.2.11-r1)
Executing busybox-1.29.3-r10.trigger
Executing ca-certificates-20190108-r0.trigger
OK: 44 MiB in 39 packages
 ---> 3b07ed10e4fc
Removing intermediate container ccd03143d53f
Step 4/6 : WORKDIR /cyber-dojo
 ---> 2feec531371b
Removing intermediate container f437cfb8c3e0
Step 5/6 : COPY Gemfile .
 ---> ded2ebc54fd2
Step 6/6 : RUN apk --update --upgrade --no-cache add --virtual build-dependencies build-base   && echo "gem: --no-rdoc --no-ri" > ~/.gemrc   && bundle config --global silence_root_warning 1   && bundle install   && apk del build-dependencies build-base   && rm -vrf /var/cache/apk/*
 ---> Running in 5af0a4863f74
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/16) Installing binutils (2.31.1-r2)
(2/16) Installing libmagic (5.36-r0)
(3/16) Installing file (5.36-r0)
(4/16) Installing isl (0.18-r0)
(5/16) Installing libgomp (8.3.0-r0)
(6/16) Installing libatomic (8.3.0-r0)
(7/16) Installing mpfr3 (3.1.5-r1)
(8/16) Installing mpc1 (1.0.3-r1)
(9/16) Installing gcc (8.3.0-r0)
(10/16) Installing musl-dev (1.1.20-r4)
(11/16) Installing libc-dev (0.7.1-r0)
(12/16) Installing g++ (8.3.0-r0)
(13/16) Installing make (4.2.1-r2)
(14/16) Installing fortify-headers (1.0-r0)
(15/16) Installing build-base (0.5-r1)
(16/16) Installing build-dependencies (0)
Executing busybox-1.29.3-r10.trigger
OK: 200 MiB in 55 packages
Fetching gem metadata from https://rubygems.org/.............
Fetching gem metadata from https://rubygems.org/.
Resolving dependencies....
Fetching rake 12.3.2
Installing rake 12.3.2
Fetching concurrent-ruby 1.1.5
Installing concurrent-ruby 1.1.5
Fetching i18n 1.6.0
Installing i18n 1.6.0
Fetching minitest 5.11.3
Installing minitest 5.11.3
Fetching thread_safe 0.3.6
Installing thread_safe 0.3.6
Fetching tzinfo 1.2.5
Installing tzinfo 1.2.5
Fetching activesupport 5.2.3
Installing activesupport 5.2.3
Fetching builder 3.2.3
Installing builder 3.2.3
Fetching erubi 1.8.0
Installing erubi 1.8.0
Fetching mini_portile2 2.4.0
Installing mini_portile2 2.4.0
Fetching nokogiri 1.10.3
Installing nokogiri 1.10.3 with native extensions
Fetching rails-dom-testing 2.0.3
Installing rails-dom-testing 2.0.3
Fetching crass 1.0.4
Installing crass 1.0.4
Fetching loofah 2.2.3
Installing loofah 2.2.3
Fetching rails-html-sanitizer 1.0.4
Installing rails-html-sanitizer 1.0.4
Fetching actionview 5.2.3
Installing actionview 5.2.3
Fetching rack 2.0.7
Installing rack 2.0.7
Fetching rack-test 1.1.0
Installing rack-test 1.1.0
Fetching actionpack 5.2.3
Installing actionpack 5.2.3
Fetching nio4r 2.3.1
Installing nio4r 2.3.1 with native extensions
Fetching websocket-extensions 0.1.3
Installing websocket-extensions 0.1.3
Fetching websocket-driver 0.7.0
Installing websocket-driver 0.7.0 with native extensions
Fetching actioncable 5.2.3
Installing actioncable 5.2.3
Fetching globalid 0.4.2
Installing globalid 0.4.2
Fetching activejob 5.2.3
Installing activejob 5.2.3
Fetching mini_mime 1.0.1
Installing mini_mime 1.0.1
Fetching mail 2.7.1
Installing mail 2.7.1
Fetching actionmailer 5.2.3
Installing actionmailer 5.2.3
Fetching activemodel 5.2.3
Installing activemodel 5.2.3
Fetching arel 9.0.0
Installing arel 9.0.0
Fetching activerecord 5.2.3
Installing activerecord 5.2.3
Fetching mimemagic 0.3.3
Installing mimemagic 0.3.3
Fetching marcel 0.3.3
Installing marcel 0.3.3
Fetching activestorage 5.2.3
Installing activestorage 5.2.3
Using bundler 1.17.1
Fetching daemons 1.3.1
Installing daemons 1.3.1
Fetching docile 1.3.1
Installing docile 1.3.1
Fetching eventmachine 1.2.7
Installing eventmachine 1.2.7 with native extensions
Fetching ffi 1.11.1
Installing ffi 1.11.1 with native extensions
Fetching json 2.2.0
Installing json 2.2.0 with native extensions
Fetching method_source 0.9.2
Installing method_source 0.9.2
Fetching thor 0.20.3
Installing thor 0.20.3
Fetching railties 5.2.3
Installing railties 5.2.3
Fetching sprockets 3.7.2
Installing sprockets 3.7.2
Fetching sprockets-rails 3.2.1
Installing sprockets-rails 3.2.1
Fetching rails 5.2.3
Installing rails 5.2.3
Fetching rb-fsevent 0.10.3
Installing rb-fsevent 0.10.3
Fetching rb-inotify 0.10.0
Installing rb-inotify 0.10.0
Fetching sass-listen 4.0.0
Installing sass-listen 4.0.0
Fetching sass 3.7.4
Installing sass 3.7.4
Fetching tilt 2.0.9
Installing tilt 2.0.9
Fetching sass-rails 5.0.7
Installing sass-rails 5.0.7
Fetching simplecov-html 0.10.2
Installing simplecov-html 0.10.2
Fetching simplecov 0.16.1
Installing simplecov 0.16.1
Fetching thin 1.7.2
Installing thin 1.7.2 with native extensions
Bundle complete! 5 Gemfile dependencies, 55 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Post-install message from i18n:
...

WARNING: Ignoring APKINDEX.b89edf6e.tar.gz: No such file or directory
WARNING: Ignoring APKINDEX.737f7e01.tar.gz: No such file or directory
(1/16) Purging build-dependencies (0)
(2/16) Purging build-base (0.5-r1)
(3/16) Purging file (5.36-r0)
(4/16) Purging g++ (8.3.0-r0)
(5/16) Purging gcc (8.3.0-r0)
(6/16) Purging binutils (2.31.1-r2)
(7/16) Purging libatomic (8.3.0-r0)
(8/16) Purging libgomp (8.3.0-r0)
(9/16) Purging make (4.2.1-r2)
(10/16) Purging libc-dev (0.7.1-r0)
(11/16) Purging musl-dev (1.1.20-r4)
(12/16) Purging fortify-headers (1.0-r0)
(13/16) Purging libmagic (5.36-r0)
(14/16) Purging isl (0.18-r0)
(15/16) Purging mpc1 (1.0.3-r1)
(16/16) Purging mpfr3 (3.1.5-r1)
Executing busybox-1.29.3-r10.trigger
OK: 44 MiB in 39 packages
 ---> c66f9077962d
Removing intermediate container 5af0a4863f74
Successfully built c66f9077962d
Successfully tagged cyberdojo/web-base:latest
```

- - - -

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
