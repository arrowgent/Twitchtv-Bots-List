#!/bin/bash
# twitch-dl verify list.txt

list="$HOME/list.txt"
lnew="$HOME/list_new.txt"
lbots="$HOME/list_bots.txt"

# to remove # comments and empty lines --- grep -v "^#\|^$"

# option alphabetical or verify
while true; do
    read -p "twlist (V)erify users, (A)lphabetize list, (G)et list, (S)how list (B)ots update * exit > " vagsb
    case $vagsb in
        [Vv]* ) while read -r line
            do
# testing
#                echo "${line%%#*}";
#                twitch-dl videos "${line%%#*}";
#                grep -qi "Channel "${line%%#*}" not found";
# variable used for checking
                twitch-dl videos "${line%%#*}" --limit 1|head -2|tail -1|while read -r remove;
                    do
#                        remove=$remove
# actually editing the list.txt file
                        if [[ "echo $remove" =~ "---"|"No videos found" ]];
                            then
# caveat, if videos do exist then removed from list... *fixed*
                                echo $remove;
                                echo "${line%%#*}" user exists;
                            else
#                                echo $remove;
                                echo "${line%%#*}" user removed;
                                cat $list|grep -qi "${line%%#*}"|xargs sed -i -s -r "s/\b${line%%#*}\b//gI" "$list";
                        fi
                    done
# timeout so not spam the api
                sleep 0.69;
# read from list.txt file
            done < <(grep -vi "^#\|^$" $list);
            echo "DONE: recommended alphabetize & sort before using";;
# alphabetize the list.txt file
# only real way is to create a new file then move it. this can be done in tmpfs if desired
        [Aa]* ) echo "alphabetical output -> list.txt";
                sed 's/.*/\L&/' $list|uniq|grep -vi "^#\|^$"|sort -uo $list;;
# wget latest list.txt file
        [Gg]* ) wget -N "https://raw.githubusercontent.com/arrowgent/Twitchtv-Bots-List/main/list.txt";;
        [Ss]* ) cat $list;;
# get current bot list from this api, "Currently In ~100+ Amount Of Live Channels"
        [Bb]* ) echo "update https://api.twitchinsights.net/v1/bots/online";
                curl https://api.twitchinsights.net/v1/bots/online > $lbots;
# extract and format, print to file
                cat $lbots|jq .bots[]|grep '".*"'|grep -vi "^#\|^$"|sed 's/"//g'|sed 's/,//g'|awk '{gsub(/^ +| +$/,"")} {print $0}'|sort >> $lnew;
                rm $lbots;
# remove known good safe bots (streamelements, streamlabs, etc) note only removing from api bot list, not list.txt
# may need tweaking... there are 200+ names on this list
                echo "remove known good bots";
                gbot=( buttsbot creatisbot lolrankbot moobot mtgbot nightbot pretzelrocks restreambot sery_bot soundalerts streamholics streamelements streamlabs wizebot wzbot )
                echo ${gbot[@]};
                for i in ${gbot[@]}
                do
                    cat $lnew|grep -qi ${i}|xargs sed -i -s -e "s/\b${i}\b//gI" "$lnew";
                done
# very messy... append list.txt, organize, unique, sort, remove extra files.
                cat $lnew >> $list;
                rm $lnew;
                sed 's/.*/\L&/' $list|uniq|grep -vi "^#\|^$"|sort -uo $list;;
        * ) exit;;
    esac
done
