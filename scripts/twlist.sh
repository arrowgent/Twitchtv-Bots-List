#!/bin/bash
# twitch-dl verify list.txt

list="$HOME/list.txt"
lnew="$HOME/list_new.txt"
lbots="$HOME/list_bots.txt"
#the main list.txt
thelist="https://raw.githubusercontent.com/arrowgent/Twitchtv-Bots-List/main/list.txt"
#known good bots list sanitized
gbot=$(curl -s "https://raw.githubusercontent.com/arrowgent/Twitchtv-Bots-List/main/goodbot.txt"|sed ':a;N;$!ba;s/\n/ /g')

# to remove # comments and empty lines --- grep -v "^#\|^$"

# option alphabetical or verify
while true; do
    read -p "twlist (V)erify users, (A)lphabetize list, (G)et list, (S)how list (B)ots update (D)iff * exit > " vagsbd
    case $vagsbd in
        [Vv]* ) while read -r line
            do
                twitch-dl videos "${line%%#*}" --limit 1|head -2|tail -1|while read -r remove;
                    do
#                        remove=$remove
# actually editing the list.txt file
                        if [[ "echo $remove" =~ "---"|"No videos found" ]];
                            then
# GraphQL query failed *needfix
# * service timeout *needfix
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
# curl latest list.txt file
        [Gg]* ) curl "$thelist" > $list;;
        [Ss]* ) cat $list;;
# get current bot list from this api, "Currently In ~150+ Amount Of Live Channels"
        [Bb]* ) echo "update https://api.twitchinsights.net/v1/bots/online";
                curl https://api.twitchinsights.net/v1/bots/online > $lbots;
# extract and format, print to file
                echo "converting json to username list & sort";
                cat $lbots|jq .bots[]|grep '".*"'|grep -vi "^#\|^$"|sed 's/"//g'|sed 's/,//g'|awk '{gsub(/^ +| +$/,"")} {print $0}'|sort >> $lnew;
                rm $lbots;
# remove known good safe bots (streamelements, streamlabs, etc) note only removing from api bot list, not list.txt
                echo "remove known good bots";
                echo ${gbot[@]};
                for i in ${gbot[@]}
                do
                    cat $lnew|grep -qi ${i}|xargs sed -i -s -e "s/\b${i}\b//gI" "$lnew";
# ensure list.txt is sanitized
                    cat $list|grep -qi ${i}|xargs sed -i -s -e "s/\b${i}\b//gI" "$list";
                done
# very messy... append list.txt, organize, unique, sort, remove extra files.
                cat $lnew >> $list;
                rm $lnew;
                echo "sorting list.txt";
                sed 's/.*/\L&/' $list|uniq|grep -vi "^#\|^$"|sort -uo $list;
                echo "DONE: recommended alphabetize & sort before using";;
# diff list.txt
        [Dd]* ) echo "show diff list.txt - list2.txt";
                echo "move list";
                mv $list $lnew;
                echo "get list again";
                curl -s "$thelist" > $list;
                echo "alphabetize list for sanitation";
                sed 's/.*/\L&/' $list|uniq|grep -vi "^#\|^$"|sort -uo $list;
                echo "if different then show difference here";
                diff $list $lnew;
                echo "replacing list.txt";
                mv $lnew $list;
                echo "done showing diff";;
        * ) exit;;
    esac
done
