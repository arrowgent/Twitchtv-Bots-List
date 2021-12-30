#!/bin/bash

#https://dev.twitch.tv/docs/api/reference#get-users

list="$HOME/list.txt"

# read list and query userdates
while true; do
    read -p "twlist (U)serinfo * exit > " u
    case $u in
        [Uu]* ) while read -r line
            do
# variable used for checking
                userdate=$(curl -s -X GET "https://api.twitch.tv/helix/users?login=${line%%#*}" \
                -H 'Authorization: Bearer YOUR-OAUTH-TOKEN' \
                -H 'Client-Id: YOUR-CLIENTID-TOKEN')
                echo "${line%%#*}";
                echo $userdate|grep -Go '"created_at":".*"'
                echo "";
# timeout so not spam the api
                sleep 0.69;
# read from list.txt file
            done < <(grep -vi "^#\|^$" $list);;
        * ) exit;;
    esac
done
