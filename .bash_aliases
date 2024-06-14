
# ::::::::::::::::::::::::::::::::
#   Basic
# ::::::::::::::::::::::::::::::::

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Detailed list including hidden files with type indicators
alias ll='ls -alF'

# List all files excluding . and ..
alias la='ls -A'

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

take() { mkdir -p "$@" && cd "$@";}

alias c='clear'
alias r='reset'


# ::::::::::::::::::::::::::::::::
#   Better `grep`
# ::::::::::::::::::::::::::::::::

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hgrep="history | grep"


# ::::::::::::::::::::::::::::::::
#   Networking
# ::::::::::::::::::::::::::::::::

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

piing() {
  /bin/ping -A -c 5 "$(echo "$1" | cut -d "/" -f3)"
} # piing https://github.com/404/403
# Check host reachability using ping, sending 5 packets. Extracts hostname from URL.

diig() {
  dig "$(echo "$1" | cut -d "/" -f3)"
} # diig https://www.google.com/404/403
# Perform DNS lookup using dig. Extracts hostname from URL.

function cjson () {
  curl -s $1 | python -mjson.tool
} # Fetches and formats JSON data from a URL using curl and Python's JSON tool


# ::::::::::::::::::::::::::::::::
#   Compress & Extract
# ::::::::::::::::::::::::::::::::

function tarz() {
  [ "$1" != "" ] && tar -czRf $1.tar.gz $1 && echo "$1.tar.gz created successfully!"|| echo "Usage: tarz [folder_or_file]"
}

function tarj() {
  [ "$1" != "" ] && tar -cjRf $1.tar.bz2 $1 && echo "$1.tar.bz2 created successfully!" || echo "Usage: tarj [folder_or_file]"
}

function utar() {
  [ "$1" != "" ] && tar -xvf $1 || echo "Usage: utar [tar_file_name]"
}

function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}


# ::::::::::::::::::::::::::::::::
#   Utils
# ::::::::::::::::::::::::::::::::

md5(){ echo -n "$1" | md5sum; }

# Url decode
alias urldecode='python -c "import sys, os, urllib as ul; name = ul.unquote_plus(sys.argv[1]); print name; os.rename(sys.argv[1], name)"'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Corrects your previous command with 'thefuck'
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

alias ?='man'

alias f='file'
alias s='stat'
alias rm='rm -i'

# Friendly cat
function cat(){
  /bin/cat $@ | head -n100
}

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'


# ::::::::::::::::::::::::::::::::
#   Docker
# ::::::::::::::::::::::::::::::::

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }


# ::::::::::::::::::::::::::::::::
#   Git
# ::::::::::::::::::::::::::::::::

# Useful Git aliases
# Thanks to awesome: https://github.com/GitAlias/gitalias
curl https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt -o gitalias.txt
git config --global include.path gitalias.txt

# View all global Git configurations
alias gconfig='git config --list --global'

# View global Git user name and email
alias guser='git config --global user.name && git config --global user.email'

# View all global Git aliases
alias galias='git config --global --get-regexp alias'

# View all global Git URL configurations
alias gurl='git config --global --get-regexp url'

# View all global Git core configurations
alias gcore='git config --global --get-regexp core'

# View all global Git credential configurations
alias gcredential='git config --global --get-regexp credential'
