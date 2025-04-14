#!/bin/bash

# Переключаемся на пользователя myuser для запуска серверов (это важно для безопасности)
if [ "$(id -u)" = "0" ]; then
    exec su-exec myuser "$0" "$@"
fi

# Запускаем FastCGI сервер
spawn-fcgi -p 8080 ./fastcgi_server
if [ $? -ne 0 ]; then
    echo "Ошибка запуска FastCGI сервера!"
    exit 1
fi

# Запускаем nginx в режиме foreground (на переднем плане)
exec nginx -g 'daemon off;'
if [ $? -ne 0 ]; then
    echo "Ошибка запуска nginx!"
    exit 1
fi

