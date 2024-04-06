FROM composer:2.7.1 AS composer
FROM spiralscout/roadrunner:2023 AS roadrunner
FROM alpine:3.19

ARG ALPINE_VERSION=3.19

LABEL Maintainer="Morteza Fathi <mortezaa.fathi@gmail.com>" \
      Description="Lightweight container for PHP 8.3 with Nginx & Roadrunner based on Alpine Linux 3.19."

RUN echo https://mirrors.pardisco.co/alpine/v$ALPINE_VERSION/main > /etc/apk/repositories
RUN echo https://mirrors.pardisco.co/alpine/v$ALPINE_VERSION/community >> /etc/apk/repositories

# Install packages and remove default server definition
RUN apk add --no-cache php83 \
  php83-pcntl\
  php83-xml\
  php83-xmlwriter\
  php83-simplexml\
  php83-xmlreader\
  php83-session\
  php83-pdo_mysql\
  php83-pdo_sqlite\
  php83-tokenizer\
  php83-fileinfo\
  php83-json\
  php83-mbstring\
  php83-openssl\
  php83-zip\
  php83-phar\
  php83-iconv\
  php83-dom\
  php83-curl\
  php83-intl \
  php83-sockets \
  php83-posix

RUN apk add --no-cache nginx\
    supervisor \
    curl \
    tzdata \
    nano

RUN ln -s /usr/bin/php83 /usr/bin/php

# Install PHP tools
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# Configure nginx
COPY .docker/dev/config/nginx.conf /etc/nginx/nginx.conf

COPY .docker/dev/config/php.ini /etc/php82/conf.d/custom.ini

# Configure supervisord
COPY .docker/dev/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN set -x \
	&& adduser -u 1000 -D -S -G www-data www-data

# Setup document root
RUN mkdir -p /app

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R www-data.www-data /app && \
  chown -R www-data.www-data /run && \
  chown -R www-data.www-data /var/lib/nginx && \
  chown -R www-data.www-data /var/log/nginx

# Switch to use a non-root user from here on
USER www-data

# Add application
WORKDIR /app
COPY --chown=www-data ./ /app

RUN npm install

RUN chmod 755 .docker/dev/docker-entrypoint.sh

# Expose the port nginx is reachable on
EXPOSE 8080

# ENTRYPOINT [""]
ENTRYPOINT ["./.docker/dev/docker-entrypoint.sh"]
