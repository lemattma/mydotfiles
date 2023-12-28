# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
export COLS_NUMB=$(tput cols)

export COL_OFF=$(tput sgr0)
export COL_BOLD=$(tput bold)
export COL_UNDER=$(tput smul)
export COL_BOLDUNDER="$COL_BOLD$COL_UNDER"

export COL_BLACK=$(tput setaf 0)
export COL_RED=$(tput setaf 1)
export COL_GREEN=$(tput setaf 2)
export COL_YELLOW=$(tput setaf 3)
export COL_BLUE=$(tput setaf 4)
export COL_MAGENTA=$(tput setaf 5)
export COL_CYAN=$(tput setaf 6)
export COL_WHITE=$(tput setaf 7)
export COL_DIM=$(tput dim)
# export COL_NOTUSED=$(tput setaf 8)
# export COL_DEFAULT=$(tput setaf 9)

export COL_BLACK_BOLD="$COL_BLACK$COL_BOLD"
export COL_RED_BOLD="$COL_RED$COL_BOLD"
export COL_GREEN_BOLD="$COL_GREEN$COL_BOLD"
export COL_YELLOW_BOLD="$COL_YELLOW$COL_BOLD"
export COL_BLUE_BOLD="$COL_BLUE$COL_BOLD"
export COL_MAGENTA_BOLD="$COL_MAGENTA$COL_BOLD"
export COL_CYAN_BOLD="$COL_CYAN$COL_BOLD"
export COL_WHITE_BOLD="$COL_WHITE$COL_BOLD"

export COL_BLACK_BOLDUNDER="$COL_BLACK$COL_BOLDUNDER"
export COL_RED_BOLDUNDER="$COL_RED$COL_BOLDUNDER"
export COL_GREEN_BOLDUNDER="$COL_GREEN$COL_BOLDUNDER"
export COL_YELLOW_BOLDUNDER="$COL_YELLOW$COL_BOLDUNDER"
export COL_BLUE_BOLDUNDER="$COL_BLUE$COL_BOLDUNDER"
export COL_MAGENTA_BOLDUNDER="$COL_MAGENTA$COL_BOLDUNDER"
export COL_CYAN_BOLDUNDER="$COL_CYAN$COL_BOLDUNDER"
export COL_WHITE_BOLDUNDER="$COL_WHITE$COL_BOLDUNDER"


colors_show_codes() {
  printf "|039| \033[39mDefault \033[m  |049| \033[49mDefault \033[m  |037| \033[37mLight gray \033[m     |047| \033[47mLight gray \033[m\n"
  printf "|030| \033[30mBlack \033[m    |040| \033[40mBlack \033[m    |090| \033[90mDark gray \033[m      |100| \033[100mDark gray \033[m\n"
  printf "|031| \033[31mRed \033[m      |041| \033[41mRed \033[m      |091| \033[91mLight red \033[m      |101| \033[101mLight red \033[m\n"
  printf "|032| \033[32mGreen \033[m    |042| \033[42mGreen \033[m    |092| \033[92mLight green \033[m    |102| \033[102mLight green \033[m\n"
  printf "|033| \033[33mYellow \033[m   |043| \033[43mYellow \033[m   |093| \033[93mLight yellow \033[m   |103| \033[103mLight yellow \033[m\n"
  printf "|034| \033[34mBlue \033[m     |044| \033[44mBlue \033[m     |094| \033[94mLight blue \033[m     |104| \033[104mLight blue \033[m\n"
  printf "|035| \033[35mMagenta \033[m  |045| \033[45mMagenta \033[m  |095| \033[95mLight magenta \033[m  |105| \033[105mLight magenta \033[m\n"
  printf "|036| \033[36mCyan \033[m     |046| \033[46mCyan \033[m     |096| \033[96mLight cyan \033[m     |106| \033[106mLight cyan \033[m\n"
}

colors_show_tput() {
  for fg_color in {0..7}; do
    set_foreground=$(tput setaf $fg_color)
    for bg_color in {0..7}; do
      set_background=$(tput setab $bg_color)
      echo -n $set_background$set_foreground
      printf ' F:%s B:%s ' $fg_color $bg_color
    done
    echo $(tput sgr0)
  done
}