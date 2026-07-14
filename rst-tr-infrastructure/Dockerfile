# syntax=docker/dockerfile:1

# Versions
FROM php:8.1-fpm-alpine

# Use the default production configuration
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Get latest ca cert
RUN wget -c https://curl.se/ca/cacert.pem && mv cacert.pem /etc/ssl/certs/

# Install dependencies
RUN set -eux; \
    apk add --no-cache \
    git \
    alpine-conf

# Install PIE for installing PHP extensions
RUN set -eux; \
    curl -fsSL https://github.com/php/pie/releases/latest/download/pie.phar \
        -o /usr/local/bin/pie \
    && chmod +x /usr/local/bin/pie

# Install php extensions
RUN set -eux; \
    apk add --no-cache \
        freetype \
        libpng \
        libjpeg-turbo \
        libwebp \
        libzip \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        linux-headers \
        libtool \
        # for mongodb
        openssl-dev \
        build-base \
        # Install dependencies for gd extension
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        # Install dependencies for zip extension
        libzip-dev \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install -j$(nproc) mysqli pdo_mysql gd zip \
    && pie install xdebug/xdebug \
    && pie install mongodb/mongodb-extension:^1.13.0 \
    && apk del .build-deps

# Custom xdebug configuration
COPY ./php-custom-xdebug-config.ini "$PHP_INI_DIR/conf.d/custom-xdebug-config.ini"

# Install Composer
COPY --from=composer:latest --link /usr/bin/composer /usr/local/bin/composer

# Setup a non-root user
RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv/tr

EXPOSE 9000
