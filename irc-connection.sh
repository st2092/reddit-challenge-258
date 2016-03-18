#!/bin/bash

# This is the solution to the reddit challenge #258. Given the server, port,
# nickname, username, and real name open a socket connection with the server
# to exchange messages required for initialization. Once connection gets 
# establish we maintain connection by replying to PING messages from the server.

printf "Server: "
read server

printf "Port: "
read port

printf "Nick name: "
read nick_name

printf "Username: "
read username

printf "Real name: "
read real_name

printf "Server: $server,\nPort: $port,\nNick name: $nick_name,\nUsername: $username,\nReal name: $real_name\n"
