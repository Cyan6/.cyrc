# Created by newuser for 5.0.2
tmuxR(){
	if (tmux ls | grep -vq attached); then
		exec tmux at
	else
		exec tmux
	fi
}

[[ -z $MC_SID ]] && [[ -z $TMUX ]] && [[ -z $SSH_CONNECTION ]] && tmuxR

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
bindkey -e

export EDITOR=vim

precmd(){
	BLU=""
	ERR=$?
	UCOL="cyan"
	PREPROMPT="%{%F{$UCOL}%}"
	[[ -h $PWD ]] && BLU="%{%F{green}%}"
	[[ $UID -eq 0 ]] && UCOL="red"
	[[ $ERR -ne 0 ]] && PREPROMPT="%{%F{red}%}$ERR%{%f%}> <$PREPROMPT"
	if [[ -z $MC_SID ]]; then
		PS1="$PREPROMPT%n%{%f%}@%m> "
		RPS1="<$BLU%~%{%f%}> <%T"
	else
		PS1="$PREPROMPT%n%{%f%}@%m:%~> "
	fi
}

alias ls="ls --color"
alias su="su -m"
alias sudo="sudo -E"
alias startx="env --unset=TMUX startx"
alias x="startx &>~/.xlog"
