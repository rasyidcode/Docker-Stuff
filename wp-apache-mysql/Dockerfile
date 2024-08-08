# syntax=docker/dockerfile:1

FROM composer:lts AS composer_upstream
FROM php:8.0-apache AS php_upstream

RUN docker-php-ext-install pdo pdo_mysql

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

RUN groupadd --gid 1000 wpuser && \
    useradd --uid 1000 --gid 1000 -m wpuser

USER wpuser

WORKDIR /var/www/html
