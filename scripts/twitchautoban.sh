#!/bin/bash

#temporary document, not real info.  generic reference from
# https://dev.twitch.tv/docs/api/reference/#ban-user

curl -X POST 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678' \
-H 'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul' \
-H 'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh' \
-H 'Content-Type: application/json' \
-d '{"data": {"user_id":"9876","reason":"no reason"}}'
