playerctl status --format '{{ playerName }}' --follow > /tmp/player-last 
playerctl -p $(tail -1 /tmp/player-last) play-pause