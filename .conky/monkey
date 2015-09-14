out_to_x no
own_window no
out_to_console yes

background no
max_text_width 0
update_interval 3.0
update_interval_on_battery 6.0
total_run_times 0
short_units on
if_up_strictness address
use_spacer yes
override_utf8_locale yes
cpu_avg_samples 4

TEXT
[
	{ "full_text" : "${if_up enp9s0} LAN: Down ${downspeed enp9s0} Up ${upspeed enp9s0} ${endif}" , "color" : "\#66ff99"},
	{ "full_text" : "${if_up eth0} LAN: Down ${downspeed eth0} Up ${upspeed eth0} ${endif}" , "color" : "\#66ff99"},
	{ "full_text" : "${if_up enp0s20u2} Tethering: Down ${downspeed enp0s20u2} Up ${upspeed enp0s20u2} ${endif}" , "color" : "\#66ff99"},
	{ "full_text" : "${if_up wlp8s0} WiFi: Down ${downspeed wlp8s0} Up ${upspeed wlp8s0} ${endif}" , "color" : "\#66ff09"},
	{ "full_text" : "${if_up wlan0} WiFi: Down ${downspeed wlan0} Up ${upspeed wlan0} ${endif}" , "color" : "\#66ff09"},
	{ "full_text" : " Uptime $uptime_short " , "color" : "\#ffffff"  },
	{ "full_text" : "${fs_free /} in Root" , "color" : "\#00ff00"  },
	{ "full_text" : " RAM ${mem} ${memperc}% " , "color" :
	    ${if_match ${memperc}<80}"\#66ff99"${else}"\#ff0000"${endif} },
	{ "full_text" : "CPU ${cpu}% ", "color" :
    	${if_match ${cpu}<80}"\#66ff99"${else}"\#ff0000"${endif} },
	{ "full_text" : "${execpi 300 ~/.conky/gmail.py}" , "color" : "\#ff9900"  },
	{ "full_text" : " Volume: ${exec amixer get Master | grep "Front Left" | grep '[0-9]*\%' -o } " , "color" : "\#ffffff"},
	{ "full_text" : " Battery ${battery BAT1} (${battery_time BAT1})", "color": "\#ffffff"},
	{ "full_text" : " ${user_names} " , "color" : "\#ffffff" },
	{ "full_text" : " $time " , "color" : "\#fff00"  }
],
