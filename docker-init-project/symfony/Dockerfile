# syntax=docker/dockerfile:1

FROM php:8.2-cli AS php_upstream
FROM composer:lts AS composer_upstream

FROM php_upstream AS php82

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget

RUN wget https://get.symfony.com/cli/installer -O - | bash

RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

RUN groupadd --gid 1000 appuser && \
    useradd --uid 1000 --gid 1000 -m appuser

USER appuser

WORKDIR /app