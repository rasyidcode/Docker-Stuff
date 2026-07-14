# syntax=docker/dockerfile:1

# Versions
FROM php:8.0-fpm-alpine

# Use the default development configuration
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Install dependencies
RUN set -eux; \
    apk add --no-cache \
    git \
    alpine-conf \
    openssl \
    openssh

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
        # Install dependencies for mongodb
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
    && docker-php-ext-install -j$(nproc) mysqli pdo_mysql gd zip calendar \
    # Install xdebug from source
    && curl -fL -o /tmp/xdebug-3.4.7.tgz https://xdebug.org/files/xdebug-3.4.7.tgz \
    && tar -xzf /tmp/xdebug-3.4.7.tgz -C /tmp \
    && rm -rf /tmp/xdebug-3.4.7.tgz \
    && cd /tmp/xdebug-3.4.7 \
    && phpize \
    && ./configure --enable-xdebug \
    && make -j$(nproc) \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/xdebug-3.4.7 \
    && rm -rf package.xml \
    # Install mongodb from source
    # && curl -fL -o /tmp/mongodb-1.17.0.tar.gz https://github.com/mongodb/mongo-php-driver/archive/refs/tags/1.17.0.tar.gz \
    && git clone --branch 1.17.0 --single-branch https://github.com/mongodb/mongo-php-driver.git /tmp/mongo-php-driver-1.17.0 \
    # && tar -xzf /tmp/mongodb-1.17.0.tar.gz -C /tmp \
    # && rm -rf /tmp/mongodb-1.17.0.tar.gz \
    && cd /tmp/mongo-php-driver-1.17.0 \
    && git submodule update --init --recursive \
    && phpize \
    && ./configure --enable-mongodb \
    && make -j$(nproc) \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/mongo-php-driver-1.17.0 \
    # Install redis from source
    && curl -fL -o /tmp/redis-6.3.0.tar.gz https://github.com/phpredis/phpredis/archive/refs/tags/6.3.0.tar.gz \
    && tar -xzf /tmp/redis-6.3.0.tar.gz -C /tmp \
    && rm -rf /tmp/redis-6.3.0.tar.gz \
    && cd /tmp/phpredis-6.3.0 \
    && phpize \
    && ./configure --enable-redis \
    && make -j$(nproc) \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/phpredis-6.3.0 \
    && docker-php-ext-enable xdebug mongodb redis \
    && apk del .build-deps

# Custom xdebug configuration
COPY ./php-custom-xdebug-config.ini "$PHP_INI_DIR/conf.d/custom-xdebug-config.ini"

# Install Composer
COPY --from=composer:latest --link /usr/bin/composer /usr/local/bin/composer

# Setup a non-root user
RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv/facility-scheduler

EXPOSE 9000
