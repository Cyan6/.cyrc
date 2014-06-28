#!/bin/zsh
#TMUX FUNCTION AND AUTOSTART
tmuxRecycle(){
	if (tmux ls | grep -vq attached); then
		exec tmux at
	else
		exec tmux -2
	fi
}
(echo $TTY | grep -vq "/dev/tty") && [[ -z $MC_SID ]] && [[ -z $TMUX ]] && [[ -z $SSH_CONNECTION ]] && tmuxRecycle

#ZSH SETTINGS
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/cy/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
bindkey -v

#ZSH FUNCTIONS
precmd(){
	LNK=""
	PREPROMPT=""
	ERR=$?
	[[ -f .showerr ]] && [[ $ERR -ne 0 ]] && PREPROMPT="$ERR> <"
	[[ $UID -eq 0 ]] && UCOL="red" || UCOL="cyan"
	PREPROMPT="$PREPROMPT%{%F{$UCOL}%}"
	[[ -h $PWD ]] && LNK="%{%F{cyan}%}"
	[[ $ERR -ne 0 ]] && PREPROMPT="%{%F{red}%}$ERR%{%f%}> <$PREPROMPT"
	if [[ -z $MC_SID ]]; then
		PS1="$PREPROMPT%n%{%f%}@%m> "
		RPS1="<$LNK%~%{%f%}> <%T"
	else
		PS1="$PREPROMPT%n%{%f%}@%m:%~> "
	fi
}

#CUSTOM BINDINGS
chpwd(){
	ls --color
}

sbcl(){
	sbclbin=/usr/bin/sbcl
	[[ $1 == "" ]] && $sbclbin --linedit ||
		$sbclbin $*
}

alias cls="clear"
alias ls="ls --color"
alias l="ls"
alias su="su -m"
alias sudo="sudo -E"
alias path="echo $PATH"
alias x="startx &>.xlog"
alias tree="tree -C"

#COMMAND NOT FOUND
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh
