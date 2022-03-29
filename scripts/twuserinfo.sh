#!/bin/bash

#https://dev.twitch.tv/docs/api/reference#get-users
#https://dev.twitch.tv/docs/api/reference#get-channel-information
#https://dev.twitch.tv/docs/api/reference#get-users-follows

# requires your tokens!
oauth="YOUR-OAUTH-TOKEN"
clientid="YOUR-CLIENTID-TOKEN"
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
                -H "Authorization: Bearer $oauth" \
                -H "Client-Id: $clientid")
                echo "${line%%#*}";
                echo $userdate|jq --raw-output '.data[0] .created_at';
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
                -H "Authorization: Bearer $oauth" \
                -H "Client-Id: $clientid")
# get channel id
                channelid=$(echo $userdate|jq --raw-output '.data[0] .id')
# channel id for broadcast title & game
                channelinfo=$(curl -s -X GET "https://api.twitch.tv/helix/channels?broadcaster_id=${channelid}" \
                -H "Authorization: Bearer $oauth" \
                -H "Client-Id: $clientid")
# show follower count
                followsid=$(curl -s -X GET "https://api.twitch.tv/helix/users/follows?to_id=${channelid}&first=1" \
                -H "Authorization: Bearer $oauth" \
                -H "Client-Id: $clientid")
                echo "${userinfo}";
                echo $userdate|jq;
                echo $channelid;
                echo $channelinfo|jq;
                echo "total followers";
                echo $followsid|jq '.total';
                echo "";
                echo "username is empty, example \"twuserinfo.sh jtv\"";
# timeout so not spam the api
                sleep 0.69;;
        * ) exit;;
    esac
done
