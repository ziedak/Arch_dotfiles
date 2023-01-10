alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# alias rm='rm -I'
alias purge='rm -rf'
alias cp='rsync -a'
alias ccp='rsync -az'
alias pcp='rsync -azP'
alias rcp='rsync -vaP --delete'
alias rmirror='rsync -rtvu --delete'
alias mv='mv -v'
alias mkdir='mkdir -p'
alias wget='wget -c'
alias cat='bat -Pp'
alias search='grep -ir --exclude-dir=".git"'
alias find='fd'
alias replace='sd'


alias disks='lsblk -o name,label,mountpoint,size,uuid'
alias ccd='(){ mkdir -p "$1"; cd "$1";}'

alias clipin='xclip -sel clip -i'
alias clipout='xclip -sel clip -o'

alias colorpick="print '\nPicking color in 5 seconds...\n' && sleep 5 && colorpicker --short --one-shot | tr -d '\n' | xclip -sel clip && xclip -sel clip -o"


# find largest files in directory
alias ducks="sudo du -cks -- * | sort -rn | head"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"


alias sc=systemctl
alias ssc='sudo systemctl'
alias sn="systemctl suspend"

alias ls="ls --color=auto --hyperlink=auto"
alias l="ls -1"
alias lg="ls -1 -g"

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first";
  alias lsc="exa";
  alias lc="exa -l";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

autoload -U zmv

# Create a new directory and enter it
function mkin() {
	mkdir -p "$@" && cd "$_";
}
take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall;
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}


exists() {
  command -v "$1" >/dev/null 2>&1
}
