FROM postgres:11.6-alpine

COPY docker/init-scripts /docker-entrypoint-initdb.d/  
