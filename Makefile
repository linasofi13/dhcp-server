# Compilador y banderas
CC = gcc
CFLAGS = -Wall -Wextra

# Directorios
SERVER_DIR = server
CLIENT_DIR = client

# Nombres de los ejecutables
SERVER_EXEC = $(SERVER_DIR)/server
CLIENT_EXEC = $(CLIENT_DIR)/client
CLIENT_MULTITHREAD_EXEC = $(CLIENT_DIR)/client_multithread

# Archivos fuente
SERVER_SRC = $(SERVER_DIR)/dhcp_server.c
CLIENT_SRC = $(CLIENT_DIR)/dhcp_client.c
CLIENT_MULTITHREAD_SRC = $(CLIENT_DIR)/dhcp_client_multithread.c

# Archivos objeto
SERVER_OBJ = $(SERVER_SRC:.c=.o)
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)
CLIENT_MULTITHREAD_OBJ = $(CLIENT_MULTITHREAD_SRC:.c=.o)

# Regla por defecto: compilar todo
all: $(SERVER_EXEC) $(CLIENT_EXEC) $(CLIENT_MULTITHREAD_EXEC)

# Compilación del servidor
$(SERVER_EXEC): $(SERVER_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Compilación del cliente
$(CLIENT_EXEC): $(CLIENT_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Compilación del cliente multithread
$(CLIENT_MULTITHREAD_EXEC): $(CLIENT_MULTITHREAD_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Regla para compilar los archivos objeto del servidor
$(SERVER_OBJ): $(SERVER_SRC)
	$(CC) $(CFLAGS) -c $< -o $@

# Regla para compilar los archivos objeto del cliente
$(CLIENT_OBJ): $(CLIENT_SRC)
	$(CC) $(CFLAGS) -c $< -o $@

# Regla para compilar los archivos objeto del cliente multithread
$(CLIENT_MULTITHREAD_OBJ): $(CLIENT_MULTITHREAD_SRC)
	$(CC) $(CFLAGS) -c $< -o $@

# Limpiar archivos objeto y ejecutables
clean:
	rm -f $(SERVER_OBJ) $(CLIENT_OBJ) $(SERVER_EXEC) $(CLIENT_EXEC) $(CLIENT_MULTITHREAD_OBJ) $(CLIENT_MULTITHREAD_EXEC)

# Ejecutar el servidor (necesita permisos de superusuario para puertos < 1024)
run-server: $(SERVER_EXEC)
	sudo ./$(SERVER_EXEC) 192.168.1.10 192.168.1.100 network_config.txt

# Ejecutar el cliente (también necesita permisos de superusuario para el puerto 68)
run-client: $(CLIENT_EXEC)
	sudo ./$(CLIENT_EXEC)

# Ejecutar el cliente multithread (también necesita permisos de superusuario para el puerto 68)
run-client-multithread: $(CLIENT_MULTITHREAD_EXEC)
	sudo ./$(CLIENT_MULTITHREAD_EXEC)

# Evitar que "make clean" falle si no hay archivos que borrar
.PHONY: all clean run-server run-client run-client-multithread
