# syntax=docker/dockerfile:1

FROM php:8.0-fpm-alpine AS php_upstream
FROM mlocati/php-extension-installer:latest AS php_extension_installer_upstream
FROM composer:latest AS composer_upstream

FROM php_upstream AS php80

COPY --from=php_extension_installer_upstream --link /usr/bin/install-php-extensions /usr/local/bin

RUN apk add --no-cache \
	git

RUN set -eux; \
	install-php-extensions \
		mysqli \
		pdo_mysql \
		intl \
		zip \
		exif \
		igbinary \
		imagick \
		intl \
		apcu \
		memcached \
		redis \
		opcache \
		timezonedb

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

USER www-data

EXPOSE 9000
