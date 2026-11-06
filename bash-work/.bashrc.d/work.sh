# bash-work/.bashrc.d/work.sh

# Contains work-specific aliases/variables.

# Quickly get to my 'scripts' folder.
alias scripts='cd ~/Documents/scripts'

# Quickly get to my 'de-suite' scripts folder.
alias de-suite='cd ~/Documents/scripts/de-suite'

# Fix my keyboard when ibus and snapd fuck up.
alias fix-keyboard='setsid pkill -f ibus-daemon &>/dev/null'

