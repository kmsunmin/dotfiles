# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# pyenv initialization
eval "$(pyenv init -)"

# pyenv virtual env initialization
eval "$(pyenv virtualenv-init -)"

# simulate behaviour that will be implemented in the future for pyenv-virtualenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## Bash Prompt config (using config from JohnGrib's dotfile)
# colors
GREEN='\e[0;32m\]'
B_GREEN='\e[1;32m\]'
MAGENTA='\e[0;35m\]'
B_MAGENTA='\e[1;35m\]'
YELLOW='\e[0;33m\]'
B_YELLOW='\e[1;33m\]'
B_RED='\e[1;31m\]'
RED='\e[0;31m\]'
BLUE='\e[0;34m\]'
B_BLUE='\e[1;34m\]'
B_CYAN='\e[1;36m\]'
RED='\e[0;31m\]'
WHITE='\e[1;37m\]'
COLOR_END='\[\033[0m\]'

# Prompt for Git------------------------------------------------------------------
function gitPrompt {
    # 2> /dev/null: redirect stderr to null space (black hole)
    # 1> /dev/null: redirect stdout to null space (black hole)
    git status --short 2> /dev/null 1> /dev/null
    # $?: exit code of the previous process
    # exit code 0: everything is OK
    # exit code 1: minor problem/warnings
    # exit code 2: fatal error
    if [ "$?" -ne "0" ]; then
        return 1
    else
        # grep '^\*': search for branch name that starts with *
        # cut -c 3-: cut line at position 3 until the end (removing '* ')
        branch="`git branch | grep '^\*' | cut -c 3-`"
        # \033: an escape character in octal form
        # [1;031m]: colour red
        # [0m: reset the colour
        branch_str="\033[1;031m$branch\033[0m"

        # awk: a scripting language mostly used for pattern scanning and processing
        #      for each line of a document
        # awk '{print $1}': print the 1st field of the line given
        #  - status of each file in git (modified, added, deleted, etc)
        # uniq -c: count repeated lines and display a number as a prefix with the line
        # tr: translate new line characters with empty space
        # sed: process/edit one line at a time
        # - flag r: extended regex pattern
        # - 1: 's/([0-9])+ /\1/g': replace one or more numeric characters to first group
        # - 2: s/  */ /g: replace the empty spaces to single space
        # - 3: s/ *$//g: replace to lingering empty spaces to none
        stat=`git s \
            | awk '{print $1}' \
            | sort | uniq -c \
            | tr '\n' ' ' \
            | sed -E 's/([0-9]+) /\1/g; s/  */ /g; s/ *$//'`

        stash_size=`git stash list | wc -l | sed 's/ //g'`
        stash_icon=" \e[0;92m≡ \033[0m"
	printf "[$branch_str]$stat$stash_icon$stash_size"
        return 0
    fi
}

# Prompt for Virtual Environment -----------------------------------------------
function virtualEnvPrompt {
    if [ -z ${VIRTUAL_ENV} ]; then
        virtualenv=""
        virtualenv_str=""
    else
        virtualenv="`basename $VIRTUAL_ENV`"
        virtualenv_str="(\033[1;036m$virtualenv\033[0m)"
    fi
    printf "$virtualenv_str" 
    return 0
}

# Bash Prompt
export PS1="${B_YELLOW}\$(date '+%Y-%m-%d-%a') \
${B_YELLOW}\$(date +%T) \
${WHITE}\u \
${WHITE}\h \
${B_GREEN}\w \
${COLOR_END}\
\$(gitPrompt) \
\$(virtualEnvPrompt)\n\$ "


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

