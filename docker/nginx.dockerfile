FROM nginx

ARG environment

RUN useradd obdeploy && \
    rm -rf /etc/nginx/fastcgi.conf /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf && \
    mkdir -p /var/gateway /var/cache/nginx/ && \
    chown -R obdeploy:obdeploy /var/gateway /var/log/nginx /etc/nginx /var/cache/nginx  
COPY docker/base/etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY docker/base/etc/nginx/nginx.conf /etc/nginx/nginx.conf

COPY docker/images/gateway/$environment/etc/nginx/conf.d/gateway.conf /etc/nginx/conf.d/gateway.conf

