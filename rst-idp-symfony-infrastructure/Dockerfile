# syntax=docker/dockerfile:1

# Versions
FROM php:8.2-fpm-alpine AS php_upstream
FROM mlocati/php-extension-installer:latest AS php_extension_installer_upstream
FROM composer:latest AS composer_upstream

FROM php_upstream AS php82_fpm

# Use the default production configuration
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=php_extension_installer_upstream --link /usr/bin/install-php-extensions /usr/local/bin

RUN apk add --no-cache \
    git \
    openssh \
    make \
    alpine-conf

# -e -> Exit on Error
# -u -> Treat Unset Variables as Errors
# -x -> Print Commands
RUN set -eux; \
    install-php-extensions \
        mysqli \
        pdo_mysql \
        intl \
        zip \
        opcache

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv

EXPOSE 9000