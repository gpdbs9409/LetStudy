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
