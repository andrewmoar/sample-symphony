### Локальный запуск проекта

Скачаивание образ
    
    doker login
    docker pull registry.local.net/pg/base-dev:latest
    
Запуск контейнера

    docker run -p 9010:9000 -p 9011:9011 -v /var/www/pg/app:/var/gateway --name gateway-dev-local registry.local.net/pg/gateway-dev-local:master 

Где:
- /var/www/pg/app - путь до локального нахождения файлов проекта
- 9010 - на котором будет слушатся php из контейнера
- 9011 - порт для xdebug ( менять первое значение )
