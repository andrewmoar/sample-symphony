ARG repo
FROM $repo

ARG environment

# Prepare application folder
RUN mkdir -p /var/gateway && \
    useradd obdeploy && \
    mkdir /run/php-fpm /var/log/php-fpm && \
    chown -R obdeploy:obdeploy /run/php-fpm /var/log/php-fpm /var/gateway /usr/local/etc/php-fpm.d/ && \
    chmod -R 0777 /var/gateway

USER obdeploy
COPY ./app /var/gateway
WORKDIR /var/gateway

#copy .env
#TODO на будущее здесь надо пробрасывать конфиг в зависимости от проекта, а не только в зависимости от среды
COPY ./docker/environments/$environment/env /var/gateway/.env
COPY ./docker/images/gateway/$environment/etc/php-fpm.d/www.conf $PHP_INI_DIR/conf.d/
COPY ./docker/images/gateway/$environment/etc/php/php.ini $PHP_INI_DIR/php.ini

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install and init application
RUN rm -rf /var/gateway/docker && \
    composer install --no-dev --profile --no-interaction 

# Set entrypoint
CMD ["php-fpm", "--nodaemonize"]
