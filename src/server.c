#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <pthread.h>

#define PORT 8080
#define BUFFER_SIZE 1024
#define MAX_QUIZZES 100

typedef struct {
    char question[BUFFER_SIZE];
    char answer[BUFFER_SIZE];
} Quiz;

Quiz quizzes[MAX_QUIZZES];
int quiz_count = 0;

typedef struct {
    int socket;
    char name[BUFFER_SIZE];
} Client;

Client clients[10];
int client_count = 0;
pthread_mutex_t clients_mutex = PTHREAD_MUTEX_INITIALIZER;

// Load quizzes from file
void load_quizzes(const char *file_path) {
    FILE *file = fopen(file_path, "r");
    if (!file) {
        perror("Failed to open quiz file");
        exit(EXIT_FAILURE);
    }

    char line[BUFFER_SIZE];
    while (fgets(line, sizeof(line), file) && quiz_count < MAX_QUIZZES) {
        char *token = strtok(line, ",");
        if (token) {
            strncpy(quizzes[quiz_count].question, token, sizeof(quizzes[quiz_count].question) - 1);
            token = strtok(NULL, "\n");
            if (token) {
                strncpy(quizzes[quiz_count].answer, token, sizeof(quizzes[quiz_count].answer) - 1);
                quiz_count++;
            }
        }
    }
    fclose(file);

    if (quiz_count == 0) {
        fprintf(stderr, "No quizzes loaded.\n");
        exit(EXIT_FAILURE);
    }
}

// Send message to all clients
void send_message_to_all(const char *message) {
    pthread_mutex_lock(&clients_mutex);
    for (int i = 0; i < client_count; ++i) {
        write(clients[i].socket, message, strlen(message));
    }
    pthread_mutex_unlock(&clients_mutex);
}

void *handle_client(void *arg) {
    int client_socket = *(int *)arg;
    char buffer[BUFFER_SIZE], response[BUFFER_SIZE];
    char name[BUFFER_SIZE];

    // Get client name
    if (read(client_socket, name, sizeof(name)) <= 0) {
        close(client_socket);
        return NULL;
    }
    name[strcspn(name, "\n")] = '\0'; // Remove newline

    // Add client to the list
    pthread_mutex_lock(&clients_mutex);
    clients[client_count].socket = client_socket;
    strncpy(clients[client_count].name, name, sizeof(clients[client_count].name) - 1);
    client_count++;
    pthread_mutex_unlock(&clients_mutex);

    snprintf(buffer, sizeof(buffer), "%s님이 입장하셨습니다.\n", name);
    send_message_to_all(buffer);

    // Select random quiz
    srand(time(NULL));
    int quiz_index = rand() % quiz_count;
    snprintf(buffer, sizeof(buffer), "퀴즈: %s\n", quizzes[quiz_index].question);
    write(client_socket, buffer, strlen(buffer));

    // Handle client messages
    while (1) {
        int bytes_received = read(client_socket, buffer, sizeof(buffer) - 1);
        if (bytes_received <= 0) {
            break;
        }
        buffer[bytes_received] = '\0';

        if (strcmp(buffer, quizzes[quiz_index].answer) == 0) {
            snprintf(response, sizeof(response), "%s님이 정답을 맞혔습니다! 정답: %s\n", name, quizzes[quiz_index].answer);
            send_message_to_all(response);
        } else {
            snprintf(response, sizeof(response), "%s: %s", name, buffer);
            send_message_to_all(response);
        }
    }

    // Remove client from the list
    close(client_socket);
    pthread_mutex_lock(&clients_mutex);
    for (int i = 0; i < client_count; ++i) {
        if (clients[i].socket == client_socket) {
            for (int j = i; j < client_count - 1; ++j) {
                clients[j] = clients[j + 1];
            }
            client_count--;
            break;
        }
    }
    pthread_mutex_unlock(&clients_mutex);

    snprintf(buffer, sizeof(buffer), "%s님이 퇴장하셨습니다.\n", name);
    send_message_to_all(buffer);
    return NULL;
}

int main() {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_addr_size;
    pthread_t tid;

    // Load quizzes
    load_quizzes("data/input.txt");

    // Initialize server
    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(PORT);

    if (bind(server_socket, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("bind");
        close(server_socket);
        exit(EXIT_FAILURE);
    }

    if (listen(server_socket, 5) == -1) {
        perror("listen");
        close(server_socket);
        exit(EXIT_FAILURE);
    }

    printf("서버가 포트 %d에서 실행 중입니다.\n", PORT);

    while (1) {
        client_addr_size = sizeof(client_addr);
        client_socket = accept(server_socket, (struct sockaddr *)&client_addr, &client_addr_size);
        if (client_socket == -1) {
            perror("accept");
            continue;
        }
        printf("클라이언트가 연결되었습니다.\n");

        pthread_create(&tid, NULL, handle_client, (void *)&client_socket);
        pthread_detach(tid);
    }

    close(server_socket);
    return 0;
}
