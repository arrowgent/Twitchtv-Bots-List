#!/bin/bash

#https://dev.twitch.tv/docs/api/reference#get-users

list="$HOME/list.txt"
# ex: twuserinfo.sh jtv
userinfo="$1"

# read list and query userdates
while true; do
    read -p "twlist (U)serinfo from list.txt, or check (O)ne username * exit > " uo
    case $uo in
        [Uu]* ) while read -r line
            do
# variable used for checking
                userdate=$(curl -s -X GET "https://api.twitch.tv/helix/users?login=${line%%#*}" \
                -H 'Authorization: Bearer YOUR-OAUTH-TOKEN' \
                -H 'Client-Id: YOUR-CLIENTID-TOKEN')
                echo "${line%%#*}";
                echo $userdate|grep -Go '"created_at":".*"';
                echo "";
# timeout so not spam the api
                sleep 0.69;
# read from list.txt file
            done < <(grep -vi "^#\|^$" $list);;
        [Oo]* ) 
# if input is empty then default to "jtv"
                if [ "$userinfo" = "" ]; then
                    echo "username is empty, example \"twuserinfo.sh jtv\""; \
                    userinfo_e=${userinfo:="jtv"}
                fi
# variable used for checking
                userdate=$(curl -s -X GET "https://api.twitch.tv/helix/users?login=${userinfo}" \
                -H 'Authorization: Bearer YOUR-OAUTH-TOKEN' \
                -H 'Client-Id: YOUR-CLIENTID-TOKEN')
                echo "${userinfo}";
                echo $userdate|jq;
                echo "";
                echo "username is empty, example \"twuserinfo.sh jtv\"";
# timeout so not spam the api
                sleep 0.69;;
        * ) exit;;
    esac
done
