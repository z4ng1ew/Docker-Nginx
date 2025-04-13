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
