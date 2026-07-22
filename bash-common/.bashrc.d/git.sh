# bash-common/.bashrc.d/git.sh

# Git prompt and aliases used across all of my machines. Props to ClaudeAI for the work.

###############################################################################
#                              Git-aware Prompt                               #
###############################################################################
# __git_ps1 lives in git's "git-sh-prompt" library. On Ubuntu/Kubuntu,
# bash-completion auto-loads it, but source it explicitly as a fallback.
if ! declare -F __git_ps1 >/dev/null; then
    [ -r /usr/lib/git-core/git-sh-prompt ] && . /usr/lib/git-core/git-sh-prompt
fi

if declare -F __git_ps1 >/dev/null; then
    GIT_PS1_SHOWDIRTYSTATE=1        # '*' = unstaged changes, '+' = staged
    GIT_PS1_SHOWSTASHSTATE=1        # '$' = something stashed
    GIT_PS1_SHOWUNTRACKEDFILES=1    # '%' = untracked files present
    GIT_PS1_SHOWUPSTREAM=auto       # '<' behind, '>' ahead, '=' in sync

    # Same prompt as .bashrc, plus the branch/state in yellow before the '$'.
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

    # Re-add the xterm/Konsole window title that .bashrc normally prepends.
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    esac
fi

###############################################################################
#                                Git Aliases                                  #
###############################################################################
alias gs='git status -sb'                   # Short status with branch info
alias gl='git log --oneline --graph -10'    # Last 10 commits, compact
alias gd='git diff'                         # What changed (unstaged)
alias gds='git diff --staged'               # What changed (about to be committed)
alias gb='git branch -vv'                   # Branches with their upstreams

