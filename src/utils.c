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
