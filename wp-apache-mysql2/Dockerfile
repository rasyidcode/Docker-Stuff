# syntax=docker/dockerfile:1

FROM composer:lts AS composer_upstream
FROM php:8.0-apache AS php_upstream

RUN apt-get update && apt-get install -y \
    git

RUN docker-php-ext-install mysqli

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer
COPY ./wp-local.test.conf /etc/apache2/sites-available

RUN a2ensite wp-loca.test.conf && \
    a2dissite 000-default.conf

RUN a2enmod rewrite

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN chmod 775 /var/www/html

RUN groupadd --gid 1000 wpuser && \
    useradd --uid 1000 --gid 1000 -m wpuser

USER wpuser

WORKDIR /var/www/html
