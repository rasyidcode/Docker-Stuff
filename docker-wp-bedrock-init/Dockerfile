# syntax=docker/dockerfile:1

FROM php:8.0-cli AS php_upstream
FROM composer:lts AS composer_upstream

FROM php_upstream AS php80

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html
