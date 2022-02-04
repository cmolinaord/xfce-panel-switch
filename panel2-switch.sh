#!/bin/bash
# Script to switch panel2 to main monitor if single screen mode or to 
# switch between both if dual screen mode
#
# Carlos Molina (Jan 2022)

# Detect monitors
Ndisp=$(xrandr --listmonitors | head -n1 | cut -d' ' -f2)

D1=$(xrandr --listmonitors | sed -n '2 p' | cut -d' ' -f6)
if [ $Ndisp == 1 ]; then
	# Single screen
	notify-send "XFCE Panel" "Setting panel2 to single monitor ($D1)"
	xfconf-query -c xfce4-panel -p /panels/panel-2/output-name -s $D1
	
elif [ $Ndisp == 2 ]; then
	# Dual screen
	D2=$(xrandr --listmonitors | sed -n '3 p' | cut -d' ' -f6)
	
	# Switch the panel from current to the other
	curr=$(xfconf-query -c xfce4-panel -v -p /panels/panel-2/output-name)
	if [ $curr = $D1 ]; then
		xfconf-query -c xfce4-panel -p /panels/panel-2/output-name -s $D2
		notify-send "XFCE Panel" "Setting panel2 to second monitor ($D2)"
	elif [ $curr = $D2 ]; then
		xfconf-query -c xfce4-panel -p /panels/panel-2/output-name -s $D1
		notify-send "XFCE Panel" "Setting panel2 to main monitor ($D1)"
	fi
fi

