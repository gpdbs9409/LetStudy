#!/bin/bash

# 프로젝트 디렉토리 설정
PROJECT_DIR="LetStudy"
mkdir -p $PROJECT_DIR/{src,include,build,bin}

# src/main.c 생성
cat << 'EOF' > $PROJECT_DIR/src/main.c
#include <stdio.h>
#include <locale.h>
#include "quiz.h"
#include "utils.h"

void translate_task(const char *filename) {
    translate_file(filename);  // utils.c에 구현된 함수
}

int main() {
    setlocale(LC_ALL, "");  // Unicode 출력 설정

    printf("Choose a mode:\n");
    printf("1. Translation\n");
    printf("2. Quiz\n");

    int choice;
    scanf("%d", &choice);

    if (choice == 1) {
        translate_task("data/input.txt");  // 번역 데이터 파일 경로
    } else if (choice == 2) {
        run_quiz();  // quiz.c에 구현된 함수
    } else {
        printf("Invalid choice.\n");
    }

    return 0;
}
EOF

# src/quiz.c 생성
cat << 'EOF' > $PROJECT_DIR/src/quiz.c
#include <stdio.h>
#include <string.h>
#include "quiz.h"

void run_quiz() {
    char *question = "What is the capital of France?";
    char *answer = "Paris";

    printf("Quiz: %s\n", question);

    char user_input[256];
    printf("Your answer: ");
    scanf("%s", user_input);

    if (strcmp(user_input, answer) == 0) {
        printf("Correct!\n");
    } else {
        printf("Wrong. The correct answer is: %s\n", answer);
    }
}
EOF

# src/utils.c 생성
cat << 'EOF' > $PROJECT_DIR/src/utils.c
#include <stdio.h>
#include "utils.h"

void translate_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Failed to open file");
        return;
    }

    char line[256];
    printf("Translation Results:\n");
    while (fgets(line, sizeof(line), file)) {
        printf("Original: %s", line);
        // 번역 로직은 여기서 구현합니다.
        printf("Translated: [Translation of \"%s\"]\n", line);
    }

    fclose(file);
}
EOF

# include/quiz.h 생성
cat << 'EOF' > $PROJECT_DIR/include/quiz.h
#ifndef QUIZ_H
#define QUIZ_H

void run_quiz();

#endif
EOF

# include/utils.h 생성
cat << 'EOF' > $PROJECT_DIR/include/utils.h
#ifndef UTILS_H
#define UTILS_H

void translate_file(const char *filename);

#endif
EOF

# Makefile 생성
cat << 'EOF' > $PROJECT_DIR/Makefile
# 컴파일러 및 플래그 설정
CC = gcc
CFLAGS = -Iinclude -Wall -g

# 디렉토리 설정
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

# 소스 및 객체 파일 설정
SRC_FILES = \$(wildcard \$(SRC_DIR)/*.c)
OBJ_FILES = \$(patsubst \$(SRC_DIR)/%.c, \$(BUILD_DIR)/%.o, \$(SRC_FILES))

# 실행 파일
TARGET = \$(BIN_DIR)/letstudy

# 기본 빌드
all: \$(TARGET)

# 실행 파일 생성
\$(TARGET): \$(OBJ_FILES)
	@mkdir -p \$(BIN_DIR)
	\$(CC) \$(CFLAGS) -o \$@ \$^

# 객체 파일 생성
\$(BUILD_DIR)/%.o: \$(SRC_DIR)/%.c
	@mkdir -p \$(BUILD_DIR)
	\$(CC) \$(CFLAGS) -c \$< -o \$@

# 클린
clean:
	rm -rf \$(BUILD_DIR) \$(BIN_DIR)

# 실행
run-server: all
	./\$(TARGET)
EOF

echo "LetStudy 프로젝트 파일 생성 완료!"
