#!/bin/bash

# This is the solution to the reddit challenge #258. Given the server, port,
# nickname, username, and real name open a socket connection with the server
# to exchange messages required for initialization. Once connection gets 
# establish we maintain connection by replying to PING messages from the server.

# function: verifyInputs
# This function checks the inputs from the user to make sure it is valid.
# Valid inputs has no whitespaces.
function verifyInputs() 
{
    if [[ -n "$nn_extra1$nn_extra2" ]] || [[ -n "$un_extra1$un_extra2" ]]
    then
        # one or more input is invalid
        #printf >&2 "%s: %s\n" "$0" "$1"
        printf "Nick name and username must not contain any spaces."
        exit "${2:-1}"
    fi
}

# function: printInputs
# This method prints out the user inputs for server, port, nick name, username, and real name.
function printInputs()
{
    printf "Server: $server,\nPort: $port,\nNick name: $nick_name,\nUsername: $username,\nReal name: $real_name\n"
}

printf "Server: "
read server

printf "Port: "
read port

printf "Nick name: "
read nick_name nn_extra1 nn_extra2    # read assume space character as delimiter; any value set for extra# indicate spaces in user input

printf "Username: "
read username un_extra1 un_extra2

printf "Real name: "
read real_name

verifyInputs

# start connection and listen for responses
exec 3<>"/dev/tcp/$server/$port"

printInputs

while read -r line; do
    if [[ "$line" =~ ^"PING " ]];
    then
        printf >&3 '%s\r\n' "{line/PING/PONG}"
    else
        printf '%s\n' "$line"
    fi
done
