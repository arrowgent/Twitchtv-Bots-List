# python3

# https://github.com/chaosaudit/twitch_auto_ban

import socket
import time
import os.path

#  Details of the account doing the banning. Auth token can be generated here: https://twitchapps.com/tmi/

NICK = "your_mod_streamer_username"
auth_token = "oauth:####your auth token####"

#  The channel to ban from (keep the # at the beginning of the channel name)
# OLD not used anymore
#CHAN = "#channelname"

# channels.txt is a list of multiple channels or a single channel name

if not os.path.isfile("channels.txt"):
	quit("channels.txt not found")

def CHAN():
    open("channels.txt","r")
#    print(f"CHAN()")
#    chfile.close()
CHAN()

#  Add a reason for banning or leave blank ("") if not needed

ban_message = "botlist"


####################################################
### - No need to modify anything below this line ###
####################################################

#  Twitch IRC chat server details
HOST = "irc.twitch.tv"
PORT = 6667

#  Check if banlist.txt exists
# banlist.txt = list.txt or any file with a list of usernames (in the same directory)
if not os.path.isfile("banlist.txt"):
	quit("banlist.txt not found")

#  Connect to IRC and send user/auth info
con = socket.socket()
con.connect((HOST, PORT))
con.send(str.encode("USER " + HOST + "\r\n"))
con.send(str.encode("PASS " + auth_token + "\r\n"))
con.send(str.encode("NICK " + NICK.lower() + "\r\n"))
con.send(str.encode("JOIN " + str(CHAN) + "\r\n"))

#  Send IRC message with a ban command for each username in the input file
with open("channels.txt","r") as chfile:
    for word in chfile.readlines():
        with open("banlist.txt", "r") as banfile:
            for name in banfile.readlines():
                print(f"Banning {name.strip()} from {word.strip()}")
                con.send(str.encode(f"PRIVMSG {word.strip()} :/ban {name.strip()} {ban_message}\r\n"))
                time.sleep(0.333) # mods can send a max of 100 messages per 30 seconds 

con.close()
