# bash-common/.bashrc.d/common.sh

# Contains common aliases/variables used across all of my machines.

###############################################################################
#                       Custom Aliases and Functions                          #
###############################################################################
alias c="clear"                             # Clear the terminal
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp --time-style=long-iso' # Preferred 'ls' implementation
alias path='echo -e ${PATH//:/\\n}'         # path: Echo all executable Paths
alias weather='curl -L https://wttr.in'          # Get a simple weather report for home.
alias getwanaddr='dig +short txt ch whoami.cloudflare @1.0.0.1' # Get the WAN address for wherever I am.
#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f "$1" ] ; then
      case "$1" in
        *.tar.bz2)   tar xjf "$1"     ;;
        *.tar.gz)    tar xzf "$1"     ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar e "$1"     ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xf "$1"      ;;
        *.tbz2)      tar xjf "$1"     ;;
        *.tgz)       tar xzf "$1"     ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
# New 'cd' function that simply ensure that a directory listing runs every time I change directories.
function cd() {
  builtin cd "$@" && ll
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#
## SSH connection launches tmux.
#
if [[ "$TMUX" == "" ]] &&
        [[ "$SSH_CONNECTION" != "" ]]; then
    WHOAMI=$(whoami)
    if tmux has-session -t "$WHOAMI" 2>/dev/null; then
    tmux -2 attach-session -t "$WHOAMI"
    else
        tmux -2 new-session -s "$WHOAMI"
    fi
fi

#
## Show a random fortune if installed.
#
if command -v fortune >/dev/null; then
    fortune
fi

#
## Ensure that we have our $EDITOR properly defined.
#

if [[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" ]]; then
    export VISUAL=nano
    export EDITOR=nano
elif [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
    if command -v subl >/dev/null; then
        export VISUAL="subl -w"
        export EDITOR="subl -w"
    else
        export VISUAL=nano
        export EDITOR=nano
    fi
else
    export VISUAL=nano
    export EDITOR=nano
fi


