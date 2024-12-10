# 컴파일러 및 플래그 설정
CC = gcc
CFLAGS = -Iinclude -Wall -g

# 디렉토리 설정
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

# 공통 소스 파일
COMMON_SRC = $(SRC_DIR)/utils.c $(SRC_DIR)/translation.c

# 서버 및 클라이언트 소스 파일
SERVER_SRC = $(SRC_DIR)/server.c $(COMMON_SRC)
CLIENT_SRC = $(SRC_DIR)/client.c $(COMMON_SRC)

# 오브젝트 파일 생성
SERVER_OBJ = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SERVER_SRC))
CLIENT_OBJ = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(CLIENT_SRC))

# 실행 파일 이름
SERVER_BIN = $(BIN_DIR)/server
CLIENT_BIN = $(BIN_DIR)/client

# 기본 타겟 설정
all: $(SERVER_BIN) $(CLIENT_BIN)

# 서버 실행 파일 빌드 규칙
$(SERVER_BIN): $(SERVER_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# 클라이언트 실행 파일 빌드 규칙
$(CLIENT_BIN): $(CLIENT_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# 오브젝트 파일 빌드 규칙
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# 클린업 규칙
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: all clean
