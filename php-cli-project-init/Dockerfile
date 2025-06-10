# syntax=docker/dockerfile:1

FROM php:8.4-cli-alpine AS php_upstream
FROM composer:lts AS composer_upstream

FROM php_upstream AS php84

RUN apk update && apk add --no-cache \
    git \
    unzip \
    alpine-conf

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv/project