# Название выходного исполняемого файла
TARGET = fastcgi_server

# Компилятор
CXX = g++

# Флаги компилятора
CXXFLAGS = -Wall -Wextra -O2

# Флаги линковки (понадобится библиотека FastCGI)
LDFLAGS = -lfcgi

# Исходники
SRCS = my_server.c

# Объектные файлы (автоматически заменяем .cpp на .o)
OBJS = $(SRCS:.cpp=.o)

# Правило по умолчанию
all: $(TARGET)

# Сборка исполняемого файла
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

# Правило сборки .o из .cpp
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Очистка временных и бинарных файлов
clean:
	rm -f $(TARGET) $(OBJS)

# Удаление только объектников
clean-obj:
	rm -f $(OBJS)

# Переустановка (чистим и пересобираем)
re: clean all

# Сборка образа с автоматическим увеличением версии
docker-build:
	@echo "Building Docker image with Content Trust enabled..."
	@export DOCKER_CONTENT_TRUST=1 && \
	 VERSION=$(shell cat VERSION) && \
	 NEW_VERSION=$$((VERSION + 1)) && \
	 echo $$NEW_VERSION > VERSION && \
	 docker build -t my-fcgi-nginx:v$$VERSION .

# Очистка Docker образа
docker-clean:
	@docker rmi my-fcgi-nginx:v1



