## my twitch list script
* this script is designed for gnu/linux, its a bash script
* for automation, cleaning, checking, and all in one "file" for managing list.txt
* verifies if user exists on twitch (twitch-dl)
* download list.txt from here (wget)
* alphabetizes and sorts list.txt
* downloads json file bot list (external) and appends to list.txt (add your own list)
* optional show diff between the final list and current list here

*botlist* is sanitized against "known good bots", an imprecise science, if you need removal submit an issue

![twlist verify](https://raw.githubusercontent.com/arrowgent/Twitchtv-Bots-List/main/images/twlVerify_ex1.png)

## twuserinfo
bash script that reads list.txt and reports userinfo *"created_at"* date <br />
requires **your** oauth and client-id tokens

## software used in twlist (gnu/linux)
* awk
* bash
* case
* cat
* curl
* diff
* echo
* grep
* jq (used to format json)
* mv
* rm
* sed
* sleep
* sort
* twitch-dl (python on github)
* uniq
* wget
* while
* xargs
