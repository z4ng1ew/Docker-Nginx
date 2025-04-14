#!/bin/bash

echo "Начинаем настройку и запуск FastCGI сервера и Nginx..."

# Переключаемся на пользователя myuser для запуска серверов (это важно для безопасности)
if [ "$(id -u)" = "0" ]; then
    exec su-exec myuser "$0" "$@"
fi

# Запускаем FastCGI сервер
echo "Запуск FastCGI сервера на порту 8081..."
spawn-fcgi -p 8081 ./fastcgi_server
if [ $? -ne 0 ]; then
    echo "Ошибка запуска FastCGI сервера!"
    exit 1
fi

# Запускаем nginx в режиме foreground (на переднем плане)
echo "Запуск Nginx..."
exec nginx -g 'daemon off;'
if [ $? -ne 0 ]; then
    echo "Ошибка запуска nginx!"
    exit 1
fi

