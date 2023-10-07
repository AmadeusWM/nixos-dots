#!/bin/sh

FOCUSED_APP_ID=$(hyprctl activewindow -j | jq '.pid')
kill -9 $FOCUSED_APP_ID