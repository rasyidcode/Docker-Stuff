# syntax=docker/dockerfile:1

FROM php:8.0-cli-alpine AS php_upstream
FROM composer:lts AS composer_upstream

FROM php_upstream AS php84

RUN apk update && apk add --no-cache \
    git \
    unzip \
    alpine-conf

# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=ghcr.io/mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# -e -> Exit on Error
# -u -> Treat Unset Variables as Errors
# -x -> Print Commands
RUN set -eux; \
    install-php-extensions \
    intl

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer



RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv/project