//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/    /*Command*/                                                   /*Update Interval*/    /*Update Signal*/
  // Battery percentage
  {"BAT: ", "cat /sys/class/power_supply/BAT0/capacity | awk '{print $1\"%\"}'", 30, 0},

  // Volume (using amixer; adjust if using PulseAudio or PipeWire)
  {"VOL: ", "amixer get Master | awk -F'[][]' 'END{ print $2 }'",           5,                    0},

  // Clock in 24-hour format with seconds
  {"", "date '+%H:%M:%S'",                                             1,                    0},

  // Date
  {"", "date '+%d:%m:%Y'",                                             60,                   0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
