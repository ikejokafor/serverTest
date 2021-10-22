#include "network.hpp"
#include <stdio.h>


int main(int argc, char** argv)
{
    int socket = -1;
    socket = server_connect();
    if(socket == -1)
    {
        printf("Server could not connect\n");
        exit(1);
    }


    int client_socket = -1;
    struct sockaddr client;
    int c;
    client_socket = accept(socket, (struct sockaddr*)&client, (socklen_t*)&c);
    int recvNo;
    recv_data(client_socket, (uint8_t*)&recvNo, sizeof(int), sizeof(int));
    printf("Server recvd a %d\n", recvNo);


    int sentNo = 24;
    send_data(client_socket, (uint8_t*)&sentNo, sizeof(int));
    printf("Server sent %d\n", sentNo);


    return 0;
}