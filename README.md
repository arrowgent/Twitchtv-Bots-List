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
* if more than ~20-40 followers check if title & category is set
* if has followers then verify has streamed before
* **twitch-dl** videos username
* **twitch-dl** clips username
* if none exist then check username account on twitch.tv or other tools (**streamlink-twitch-gui**)
* if no profile picture or offline screen
* check BotList in Resources below if user appears in more than 50 channels simultaneously
* lastly, check other low (1) viewer channels if this bot (user) appears there simultaneously


## purpose of this list:
* informative


## missing bots user does not exist:
* hopefully twitch removes bots occasionally.  while updating this list i noticed several are missing.
* bot changed username


## my twitch list [script](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/scripts/twlist.sh)
* this list is designed for gnu/linux, its a bash script
* for automation, cleaning, checking, and all in one "file" for managing list.txt
* verifies if user exists on twitch (twitch-dl)
* wget list.txt from here (download)
* alphabetizes and sorts list.txt
* downloads json file bot list (external) and appends to list.txt (add your own list)
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
<br />

note `commanderroot can be blocked/banned also, even if you use their tool` & i recommend pasting this [list](https://github.com/arrowgent/Twitchtv-Bots-List/blob/main/list.txt) into the root ban & block filter tool.
