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
