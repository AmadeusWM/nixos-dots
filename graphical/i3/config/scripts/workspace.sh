#!/bin/sh

action="$1"
workspace="$2"

focused_output=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true) | .output')
active_prefix=0
echo $focused_output

# No Nvidia
# if [[ $focused_output == "DP-1" ]]; then
#     active_prefix=1
# fi
# if [[ $focused_output == "HDMI-1" ]]; then
#     active_prefix=2
# fi
# Nvidia
if [[ $focused_output == "DP-3" ]]; then
    active_prefix=1
fi
if [[ $focused_output == "HDMI-0" ]]; then
    active_prefix=2
fi

echo $active_prefix

target_workspace=${active_prefix}${workspace}
trim_char="0"
target_workspace=${target_workspace#$trim_char} # remove leading zero's
echo "target: ${target_workspace}"


visit() {
    i3-msg "workspace $target_workspace"
}


move() {
    i3-msg "move container to workspace $target_workspace; workspace $target_workspace"
}


movesilent() {
    i3-msg "move container to workspace $target_workspace"
}


doc() {
    echo """
Usage:
workspace [Command] [Workspace Id]
This tool is used for multiple monitor setups, 
it increments each workspace id with 10*(monitor_id).
Such that each monitor can have its own set of workspaces.

Command:
	visit       Visits the workspace
	move        Moves the active window to a workspace
	movesilent	Moves the active window to a workspace silently.
	test		Echo's the id of the workspace that will be used.
"""
}
case $action in 
  visit) 		visit ;;
  move) 		move ;; 
  movesilent) 	movesilent ;;
  *) doc;;
esac
