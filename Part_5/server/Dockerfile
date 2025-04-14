# Используем минимальный базовый образ Ubuntu
FROM ubuntu:20.04

# Создаем группу и пользователя для безопасной работы (не root)
RUN groupadd -r myuser && useradd -r -g myuser myuser

# Устанавливаем нужные пакеты и удаляем ненужные зависимости для уменьшения размера
RUN apt update && apt install -y \
    g++ \
    spawn-fcgi \
    libfcgi-dev \
    nginx \
    make \
    curl \
 && rm -rf /var/lib/apt/lists/*  # Очистка кэша apt после установки

# Удаление ненужных файлов и утилит для минимизации образа
RUN rm -f /usr/bin/passwd /usr/bin/chsh /usr/bin/su /usr/bin/mount /usr/bin/umount \
    && rm -f /usr/bin/gpasswd /usr/bin/newgrp /usr/bin/expiry /usr/sbin/pam_extrausers_chkpwd /usr/sbin/unix_chkpwd /usr/bin/chage /usr/bin/chfn

# Копируем исходники мини-сервера внутрь контейнера
COPY . /app/server

# Переходим в папку с сервером и собираем бинарник
WORKDIR /app/server
RUN make

# Копируем конфиг nginx внутрь контейнера
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Добавляем команду HEALTHCHECK для мониторинга контейнера
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

# Открываем нужные порты
EXPOSE 80

# Используем скрипт запуска, чтобы корректно обрабатывать сигналы и запускать оба процесса
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Устанавливаем пользователя для выполнения контейнера (не root)
USER myuser

# Используем exec-форму (JSON-формат) для правильной обработки сигналов
CMD ["/entrypoint.sh"]

