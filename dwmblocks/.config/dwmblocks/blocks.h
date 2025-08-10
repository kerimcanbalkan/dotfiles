//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", " tasks status", 0, 7},
	{" : ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
	{"", "[ \"$(nmcli -t -f WIFI g)\" = enabled ] && echo '󰖩 ' || echo '󰖪' ", 10, 0},
	{"", "date '+%b %d %R'", 5, 0},
};

static char delim[] = " | ";
static unsigned int delimLen = 5;
