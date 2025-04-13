# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем нужные пакеты
RUN apt update && apt install -y \
    g++ \
    spawn-fcgi \
    libfcgi-dev \
    nginx \
    make \
    curl \
 && apt clean

# Копируем исходники мини-сервера внутрь контейнера
COPY . /app/server

# Переходим в папку с сервером и собираем бинарник
WORKDIR /app/server
RUN make

# Копируем конфиг nginx внутрь контейнера
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Открываем нужные порты
EXPOSE 80

# Используем скрипт запуска, чтобы корректно обрабатывать сигналы и запускать оба процесса
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Используем exec-форму (JSON-формат) для правильной обработки сигналов
CMD ["/entrypoint.sh"]