## twitch finally implemented somethings to prevent lurkers; i am archiving this list as a feature reminder for other tools
# its been a few months since anything useful has happened.  just needed to confirm things are going well before calling an end

# [Twitchtv-Bots-List](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/list.txt)
a [list](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/list.txt) of (unwanted) known twitch bots that lurk in every channel...

![atenbot](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/images/aten_bot.png)

## definition of a lurker bot:
* a viewer on the viewer list that --
* is not following
* has hundreds of followers
* was created several days ago
* has never streamed before
* appears in multiple channels at the same time


## examples:
* ![bot](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/images/easybot1.png)
* [example list](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/images/thousands_bots.png)
* [a new one](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/images/d1fss.png)
* [4469 channels](https://github.com/arrowgent/Twitchtv-Bots-List/commit/ffedd761f1ca9dd629b74ee216c1335c96706c59#commitcomment-51199519)


## why a list of bots is useful:
* banning bots --
* removal of unwanted bots because of "spying" or data collection
* removal of unwanted bots so they are not "gifted" a subscription from "gift bombs"
* viewer list cleanup: "1 viewer", but 10 bots in viewer list..


## method of detection:
* using **CHATTY** --
* click on username to see if following current channel (or `/userinfo username`)
* if not following, then
* look at follower count & creation date
* if more than ~20-40 followers check if title & category is set (outdated: helix api)
* if has followers then verify has streamed before (3rd party tools, etc)
* **twitch-dl** videos username
* **twitch-dl** clips username
* if none exist then check username account on twitch.tv or other tools (**streamlink-twitch-gui**)
* if no profile picture or offline screen (see twuserinfo.sh)
* check BotList in Resources below if user appears in more than 50 channels simultaneously
* lastly, check other low (1) viewer channels if this bot (user) appears there simultaneously


## purpose of this list:
* informative


## missing bots user does not exist:
* hopefully twitch removes bots occasionally.  while updating this list i noticed several are missing.
* bot changed username - tracking this information was removed from api a few years ago. (see user_id)
* bot owner intentionally "deactivated" account to escape detection and will reactivate later.
* use [scripts](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/scripts) or better to quickly verify user information (limitations: helix api)


## my twitch list [script](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/scripts/twlist.sh)
* this list is designed for gnu/linux, its a bash script
* for automation, cleaning, checking, and all in one "file" for managing list.txt
* verifies if user exists on twitch (twitch-dl)
* wget list.txt from here (download)
* alphabetizes and sorts list.txt
* downloads json file bot list (external) and appends to list.txt (add your own list)
* optional show diff between the final list and current list here
<br />
*botlist* is sanitized against "known good bots", an imprecise science, if you need removal submit an issue


## issues are open:
* if you want to add suggestions for potential bots
* if you believe you are NOT a bot, we can verify that
* however if you claim NOT to be a bot, you should remove yourself from lurking in HUNDREDS or THOUSANDS of channels simultaneously (definition)


## other resources & lists:
* https://twitchinsights.net/bots
* https://twitchbots.info/bots
* https://streamscharts.com/tools/bots
* https://github.com/MrEliasen/twitch-bot-list
* https://ban-twitch-bots.sirmre.com/
* https://banlist.r3dau.pro/
* https://twitch-tools.rootonline.de/
* https://modlookup.3v.fi/top
* https://github.com/chaosaudit/twitch_auto_ban
* https://dev.twitch.tv/docs/api/reference/#ban-user
<br />

note `commanderroot can be blocked/banned also, even if you use their tool` & i recommend pasting this [list](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/list.txt) into the root ban & block filter tool.

## Agreement:
* i am under no agreement to be responsible for the use of names, information, tools, or content provided here.  any use of names here are provided by public lists or api (names are often verified manually) and are subject to change based on accessing those lists.  i am not associated with any website or list provided here or elsewhere; i work independently for my own benefit and uses for other people at my own disgression.  no attempts to circumvent, fraud, or libel of any persons or software.
* [license](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/LICENSE.md) is public domain as close as it is possible to recognize, i hold no rights over the use or distribution of "software" or "information" provided here.
