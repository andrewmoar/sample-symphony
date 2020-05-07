FROM php:7.4-fpm
#environment variable
ARG environment

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    git \
    curl \
    libssl-dev \
    libpq-dev \
    libicu-dev \
    libzip-dev \
    ssh-client \
    librabbitmq-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libldap2-dev \
    libonig-dev \
    && docker-php-ext-configure gd \
           --with-webp=/usr/include \
           --with-jpeg=/usr/include \
           --with-xpm=/usr/include \
           --with-freetype=/usr/include \
    && docker-php-ext-configure ldap \
           --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install -j$(nproc) zip opcache intl sockets pcntl gd ldap mbstring exif \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) pdo pdo_pgsql pgsql \
    && pecl update-channels \
    && pecl install APCu redis amqp \
    && docker-php-ext-enable apcu redis amqp \
    && if [ "$environment" = "dev" ]; then pecl install xdebug; fi \
    && if [ "$environment" = "dev" ]; then docker-php-ext-enable xdebug; fi \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
