# syntax=docker/dockerfile:1

FROM php:8.2-apache

COPY ./src /var/www/html

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

USER www-data
