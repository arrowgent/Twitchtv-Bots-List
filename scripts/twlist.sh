#!/bin/bash
# twitch-dl verify list.txt

list="$HOME/list.txt"
lnew="$HOME/list_new.txt"
lbots="$HOME/list_bots.txt"
rbots="$HOME/list_rem.txt"

# to remove # comments and empty lines --- grep -v "^#\|^$"

# option alphabetical or verify
while true; do
    read -p "twlist (V)erify users, (A)lphabetize list, (G)et list, (S)how list (B)ots update (D)iff * exit > " vagsbd
    case $vagsbd in
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
# GraphQL query failed *needfix
# * service timeout *needfix
                                echo $remove;
                                echo "${line%%#*}" user exists;
                            else
#                                echo $remove;
                                echo "${line%%#*}" user removed;
                                cat $list|grep -qi "${line%%#*}"|xargs sed -i -s -r "s/\b${line%%#*}\b//gI" "$list";
# if removing test twice, timeout error possible.
#                                sleep 0.555;
#                                cat $list|grep -qi "${line%%#*}"|xargs sed -i -s -r "s/\b${line%%#*}\b//gI" "$list";
# write removed users to temporary list...
# needs work
#                                echo "${line%%#*}" >> $rbot;
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
# archived CURRENT json
#                curl https://web.archive.org/web/20201116193307/https://api.twitchinsights.net/v1/bots/online >> $lbots;
#                curl https://web.archive.org/web/20201204040048/https://api.twitchinsights.net/v1/bots/online >> $lbots;
#                curl https://web.archive.org/web/20210304155609/https://api.twitchinsights.net/v1/bots/online >> $lbots;
#                curl https://web.archive.org/web/20210927112324/https://api.twitchinsights.net/v1/bots/online >> $lbots;
# archive of ALL (VERY LARGE)
#                curl https://web.archive.org/web/20201204040048/https://api.twitchinsights.net/v1/bots/all >> $lbots;
#                curl https://web.archive.org/web/20201116193307/https://api.twitchinsights.net/v1/bots/all >> $lbots;
#                curl https://web.archive.org/web/20210304155609/https://api.twitchinsights.net/v1/bots/all >> $lbots;
#                curl https://web.archive.org/web/20210927112324/https://api.twitchinsights.net/v1/bots/all >> $lbots;
# extract and format, print to file
                echo "converting json to username list & sort";
                cat $lbots|jq .bots[]|grep '".*"'|grep -vi "^#\|^$"|sed 's/"//g'|sed 's/,//g'|awk '{gsub(/^ +| +$/,"")} {print $0}'|sort >> $lnew;
                rm $lbots;
# remove known good safe bots (streamelements, streamlabs, etc) note only removing from api bot list, not list.txt
# may need tweaking... there are 200+ names on this list
                echo "remove known good bots";
                gbot=( 9kmmrbot buttsbot creatisbot dr3ddbot kikettebot logiceftbot lolrankbot mikuia moobot mtgbot nightbot playwithviewersbot pretzelrocks restreambot sery_bot songlistbot soundalerts sport_scores_bot ssakdook streamelements streamholics streamlabs wizebot wzbot )
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
# testing chatty parameters
        [Dd]* ) echo "show diff list.txt - list2.txt";
                echo "move list";
                mv $list $lnew;
                echo "get list again";
                wget -N "https://raw.githubusercontent.com/arrowgent/Twitchtv-Bots-List/main/list.txt";
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
