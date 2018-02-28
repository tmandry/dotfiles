#!/bin/bash

# Environment vairables
export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/local/mysql/bin
export EDITOR=vim

ANDROID_ENV="~/code/android/env.sh"
[ -e "$ANDROID_ENV" ] && source $ANDROID_ENV

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Completion support
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWSTASHSTATE=true

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$(__git_ps1)\$ "
else
    PS1='\u@\h:\W\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W [\$(__git_ps1)]\a\]$PS1"
    ;;
*)
    ;;
esac

UNAME=`uname`

# enable color support of ls and grep on linux
if [[ "$UNAME" == "Linux" && -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # WARNING: enabling this can cause multi-second delays due to NFS latency
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable color support of ls on mac
if [ "$UNAME" == "Darwin" ]; then
    alias ls='ls -G'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x "`which lesspipe`" ] && eval "$(SHELL=/bin/sh lesspipe)"
#[ -x "`which lesspipe.sh`" ] && export LESSOPEN="|lesspipe.sh %s"

# RVM support
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [[ -s /Users/YOURUSERNAME/.rvm/scripts/rvm ]] ; then source /Users/YOURUSERNAME/.rvm/scripts/rvm ; fi

# rubygems support
export RUBYOPT=rubygems
alias brew='RUBYOPT= brew'

# Add things specific to a given system (i.e. that shouldn't be in git)
# in .bashrc_local
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
