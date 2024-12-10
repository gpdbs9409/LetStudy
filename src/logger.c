#include <stdio.h>
#include <time.h>
#include "logger.h"

void write_log(const char *filename, const char *message) {
    FILE *file = fopen(filename, "a");
    if (file) {
        time_t now = time(NULL);
        fprintf(file, "[%s] %s\n", ctime(&now), message);
        fclose(file);
    }
}
