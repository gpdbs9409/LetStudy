#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 8080
#define NAME_LEN 32

int main() {
    int client_socket;
    struct sockaddr_in server_addr;
    char buffer[1024];
    char name[NAME_LEN];

    printf("사용자 이름을 입력하세요: ");
    fgets(name, NAME_LEN, stdin);
    name[strcspn(name, "\n")] = '\0'; // 개행 문자 제거

    client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket == -1) {
        perror("소켓 생성 실패");
        exit(EXIT_FAILURE);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // 서버 IP 주소
    server_addr.sin_port = htons(PORT);

    if (connect(client_socket, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("서버 연결 실패");
        close(client_socket);
        exit(EXIT_FAILURE);
    }

    // 사용자 이름 전송
    send(client_socket, name, strlen(name), 0);

    // 서버로부터의 메시지 수신을 위한 스레드 생성
    if (!fork()) {
        while (1) {
            int bytes_read = recv(client_socket, buffer, sizeof(buffer) - 1, 0);
            if (bytes_read <= 0) {
                printf("서버와의 연결이 종료되었습니다.\n");
                close(client_socket);
                exit(0);
            }
            buffer[bytes_read] = '\0';
            printf("%s", buffer);
        }
    }

    // 사용자 입력을 서버로 전송
    while (1) {
        fgets(buffer, sizeof(buffer), stdin);
        send(client_socket, buffer, strlen(buffer), 0);
    }

    close(client_socket);
    return 0;
}
