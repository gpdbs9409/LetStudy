#include "file_io.h"
#include <stdio.h>
#include <stdlib.h>

void read_from_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("파일 열기 실패");
        exit(EXIT_FAILURE);
    }

    char buffer[256];
    printf("[파일 읽기] %s:\n", filename);
    while (fgets(buffer, sizeof(buffer), file)) {
        printf("%s", buffer);
    }
    fclose(file);
}
