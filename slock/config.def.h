/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
  [INIT] =   "black",     /* after initialization */
  [INPUT] =  "#afd1c0",   /* during input */
  [FAILED] = "#ff5f59",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
