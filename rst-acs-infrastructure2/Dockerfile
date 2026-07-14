# syntax=docker/dockerfile:1

# Versions
FROM php:8.0-fpm-alpine

# Use the default development configuration
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Install dependencies
RUN set -eux; \
    apk add --no-cache \
    git \
    ca-certificates \
    openssl \
    alpine-conf \
    make 

# Install php extensions
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        linux-headers \
    && docker-php-ext-install -j$(nproc) mysqli pdo_mysql \
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
    && docker-php-ext-enable xdebug redis \
    && apk del .build-deps

# Custom xdebug configuration
COPY ./php-custom-xdebug-config.ini "$PHP_INI_DIR/conf.d/custom-xdebug-config.ini"

# Install Composer
COPY --from=composer:latest --link /usr/bin/composer /usr/local/bin/composer

# Setup a non-root user
RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv/rst-acs

EXPOSE 9000
