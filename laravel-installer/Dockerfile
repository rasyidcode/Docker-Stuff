# syntax=docker/dockerfile:1

FROM php:8.4-cli AS php_upstream
FROM composer:lts AS composer_upstream

FROM php_upstream AS php84

RUN apt-get update && apt-get install -y \
	git \
	unzip

COPY --from=composer_upstream --link /usr/bin/composer /usr/local/bin/composer

RUN groupadd --gid 1000 appuser && \
	useradd --uid 1000 --gid 1000 -m appuser

USER appuser

# install the laravel installer globally
RUN composer global require laravel/installer

RUN echo "export PATH=\"$PATH:$HOME/.composer/vendor/bin\"" >> ~/.bashrc

WORKDIR /app