#!/bin/bash

# Запускаем FastCGI сервер
spawn-fcgi -p 8080 ./fastcgi_server

# Запускаем nginx в режиме foreground (на переднем плане)
exec nginx -g 'daemon off;'
