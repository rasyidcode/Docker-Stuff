# syntax=docker/dockerfile:1

FROM php:8.0-apache

COPY ./apache-example.test.conf /etc/apache2/sites-available

RUN a2ensite apache-example.test.conf && \
    a2dissite 000-default.conf

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN chmod 775 /var/www/html

RUN groupadd --gid 1000 appuser && \
    useradd --uid 1000 --gid 1000 -m appuser

USER appuser

WORKDIR /var/www/html
