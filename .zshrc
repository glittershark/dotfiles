#!/usr/bin/zsh
# vim: set fdm=marker fmr={{{,}}}:

source ~/.t-completion.zsh
source ~/.fzf.zsh

stty -ixon

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# Compinstall {{{
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._- :]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 5
zstyle ':completion:*' use-cache yes
zstyle ':completion::complete:grunt::options:' expire 1
zstyle ':completion:*' prompt '%e errors'
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
# }}}

# Zsh-newuser-install {{{
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify autopushd
unsetopt beep nomatch
bindkey -v
# }}}

# Basic options {{{
set -o vi
umask 022
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH=~/.local/bin:~/.cabal/bin:$PATH:~/code/go/bin:~/bin:~/npm/bin:~/.gem/ruby/2.1.0/bin:~/.gem/ruby/2.0.0/bin:/home/smith/bin
# }}}

# Oh-My-Zsh {{{
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="bira"
ZSH_THEME="pure"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  archlinux
  battery
  colorize
  colorize
  command-not-found
  docker
  gem
  # git
  # git-extras
  zsh-geeknote
  # geeknote
  github
  gitignore
  grunt
  heroku
  lein
  node
  npm
  postgres
  python
  rails
  rake-fast
  redis
  ruby
  systemd
  themes
  tmux
  vagrant
  vi-mode
  vim
  zsh-syntax-highlighting
)

# Zsh highlight highlighters {{{
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
# }}}

source $ZSH/oh-my-zsh.sh
# }}}

# More basic options {{{
setopt no_hist_verify
setopt histignorespace
# }}}

# Utility Functions {{{

# Set the terminal's title bar.
function titlebar() {
echo -ne "\033]0;$*\007"
}

function quiet() {
"$@" >/dev/null
}

function quieter() {
"$@" >/dev/null 2>&1
}

# From http://stackoverflow.com/questions/370047/#370255
function path_remove() {
IFS=:
# convert it to an array
t=($PATH)
unset IFS
# perform any array operations to remove elements from the array
t=(${t[@]%%$1})
IFS=:
# output the new array
echo "${t[*]}"
}

# }}}

# Force screen to use zsh {{{
alias screen='screen -s /bin/zsh'
# }}}

# 256 color terminals {{{
if [[ $TERM = 'rxvt-unicode' ]]; then
  export TERM=rxvt-unicode-256color
elif [[ $TERM = 'xterm' ]]; then
  export TERM=xterm-256color
fi
# }}}

# Environment {{{
export EDITOR="/usr/bin/vim"
# }}}

# Directory Stuff {{{
alias stck='dirs -v'
alias b='cd ~1'

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias ls="command ls -FG"
else
  alias ls="command ls -F --color"
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Directory listing
alias la='ls -a'
alias ll='ls -al'
alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# alias --='cd -'

# File size
alias fs="stat -f '%z bytes'"
alias df="df -h"

# Recursively delete `.DS_Store` files
alias dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# }}}

# MPD/MPC stuff {{{
function mp() {
# Test if drive is already mounted
if ! lsblk | grep /media/external >/dev/null; then
  if ! sudo mount /media/external; then
    echo "External drive not plugged in, or could not mount"
    return 1
  fi
fi
if (mpc >/dev/null 2>&1); then
  ncmpcpp
else
  mpd &&
    (pgrep mpdscribble || mpdscribble) &&
    ncmpcpp
fi
}

# kill mp
function kmp() {
killall ncmpcpp
mpd --kill

local files

if (files=$(lsof 2>&1 | grep -v docker | grep external)); then
  echo
  echo "==> Still processes using external drive:"
  echo
  echo $files
else
  sudo umount /media/external
fi
}

alias mpl='mpc playlist'
alias mpt='mpc toggle'
alias mpa='mpc add'
alias mps='mpc search'
alias mpart='mpc search artist'
alias mpalb='mpc search album'

function mppal() {
mpc search album "$1" | mpc add &&
  mpc play;
}
# }}}

# Git stuff {{{
alias git='hub'
alias g='git'
alias gnp='git --no-pager'
# function ga() { git add "${@:-.}"; } # Add all files by default
alias ga='git add'
# Add non-whitespace changes
alias ganw='git diff -w --no-color | git apply --cached --ignore-whitespace'
alias gp='git push'
alias gpu='git push -u origin "$(git symbolic-ref --short HEAD)"'
alias gpa='gp --all'
alias gpf='gp -f'
alias gu='git pull'
alias gur='gu --rebase'
alias gf='git fetch'
alias gl='git log'
alias gg='gl --decorate --oneline --graph --date-order --all'
alias gs='git status'
alias gst='gs'
alias gsa='git stash'
alias gsad='git stash drop'
alias gss='git show stash'
alias gsl='git stash list'
alias gd='git diff'
alias gdc='gd --cached'
alias gm='git merge'
alias gci='git commit'
alias gcv='git commit --verbose'
alias gb='git branch'
alias gba='git branch -a'
alias gbg='git branch | grep'
# function gc() { git checkout "${@:-master}"; } # Checkout master by default
alias gc='git checkout'
alias gcm='gc master'
alias gco='gc'
alias gcb='gc -b'
alias gr='git reset'
alias grh='gr --hard'
alias grhh='grh HEAD'
alias grs='gr --soft'
alias gcl='git clone'
alias gcd='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gpr='g pull-request'
alias gwip='git add . && git commit -am wip'

# open all changed files (that still actually exist) in the editor
function ged() {
local files=()
for f in $(git diff --name-only "$@"); do
  [[ -e "$f" ]] && files=("${files[@]}" "$f")
done
local n=${#files[@]}
echo "Opening $n $([[ "$@" ]] || echo "modified ")file$([[ $n != 1 ]] && \
  echo s)${@:+ modified in }$@"
q "${files[@]}"
}

# git find-replace
function gfr() {
if [[ "$#" == "0" ]]; then
  echo 'Usage:'
  echo ' gg_replace term replacement file_mask'
  echo
  echo 'Example:'
  echo ' gg_replace cappuchino cappuccino *.html'
  echo
else
  find=$1; shift
  replace=$1; shift

  ORIG_GLOBIGNORE=$GLOBIGNORE
  GLOBIGNORE=*.*
  if [[ "$#" = "0" ]]; then
    set -- ' ' $@
  fi

  while [[ "$#" -gt "0" ]]; do
    for file in `git grep -l $find -- $1`; do
      sed -e "s/$find/$replace/g" -i'' $file
    done
    shift
  done

  GLOBIGNORE=$ORIG_GLOBIGNORE
fi
}

function vconflicts() {
$EDITOR $(git status --porcelain | awk '/^UU/ { print $2 }')
}

function fetchall() {
for repo in ~/code/nomi/gems/* ~/code/nomi/services/svc-users ~/code/nomi/services/svc-entities ~/code/go/src/github.com/getnomi/svc-gateway; do
  echo -e "\x1b[34;1m=======> \x1b[37;1m$repo\x1b[0m"
  git -C $repo fetch
done
}
# }}}

# Wifi {{{
alias nsw='sudo netctl switch-to'
alias office-wifi='nsw "wlp3s0-Nomi Office Wifi.wifi-menu"'
# }}}

# adb {{{
export GNEX_IP='192.168.3.30'
alias adbcon='adb connect $GNEX_IP'
alias adbdev='adb devices'
# }}}

# Golang {{{
export GOPATH="/home/griffin/code/go"
# }}}

# Tail logs {{{
# }}}

# Running stuff {{{
# }}}

# Directories {{{
alias rtb='cd ~/code/reactable'
alias tan='cd ~/code/tangent'
alias dtf='cd ~/.dotfiles'

alias svc='cd ~/code/nomi/services'
alias sve='cd ~/code/nomi/services/svc-entities'
alias svu='cd ~/code/nomi/services/svc-users'
alias gms='cd ~/code/nomi/gems'
alias jcl='cd ~/code/nomi/gems/json_client'
alias gwy='cd ~/code/nomi/services/svc-gateway'
alias plt='cd ~/code/nomi/web-platform'
alias ops='cd ~/code/nomi/web-operations'
alias pup='cd ~/code/nomi/puppet'
alias hra='cd ~/code/nomi/hiera'

export NODE_ENV='development'
# }}}

# SSH shortcuts {{{
alias awa='ssh aw2-admin.nomi.host'
# }}}

# Editing config files {{{
alias vi='vim'
alias virc='vi ~/.zshrc && source ~/.zshrc || echo "Editing failed"'
alias vivi='vi ~/.vimrc || echo "Editing failed"'
alias vigit='vi ~/.gitconfig || echo "Editing failed"'
# }}}

# XRandR {{{
alias workmon='xrandr --output DP-2 --pos 1440x900 --primary'
# }}}

# fzf {{{
v() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

c() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

co() {
  local branch
  branch=$(git branch -a | sed -s "s/\s*\**//g" | fzf --query="$1" --select-1 --exit-0) && git checkout "$branch"
}

alias cmt="git log --oneline | fzf-tmux | awk '{print \$1}'"
alias fxu='git commit --fixup "$(cmt)"'
alias shw='git show "$(cmt)"'

# fh - repeat history
# h() {
#   eval $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
# }

# fkill - kill process
fkill() {
  ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}' | xargs kill -${1:-9}
}
# }}}

# Tmux utils {{{
kill_detached() {
  for sess in $(tmux ls | grep -v attached | sed -s "s/:.*$//"); do
    tmux kill-session -t $sess;
  done
}
# }}}

# Docker {{{
alias dockercleancontainers="docker ps -a --no-trunc| grep 'Exit' | awk '{print \$1}' | xargs -L 1 -r docker rm"
alias dockercleanimages="docker images -a --no-trunc | grep none | awk '{print \$3}' | xargs -L 1 -r docker rmi"
alias dockerclean="dockercleancontainers && dockercleanimages"

alias dck='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dup=dcu
# }}}

# Vagrant {{{
alias vup='vagrant up'
alias vuu='vagrant up || vagrant up'
alias vds='vagrant destroy'
alias vdf='vagrant destroy -f'
alias vsu='vagrant suspend'
alias vhl='vagrant halt'
alias vssh='vagrant ssh'
alias vmy="vagrant ssh -c '~/mysql'"
alias vr='vdf && vup'
alias vrw='vdf web && vup web --provider docker'
# }}}

# Twitter! {{{
export TWITTER_WHOAMI='glittershark1'
alias first="awk '{print \$1}'"

alias mytl="t tl $TWITTER_WHOAMI"

# favelast <username>
function favelast() {
  t fave $(t tl -l $1 | head -n1 | first)
}

function rtlast() {
  t rt $(t tl -l $1 | head -n1 | first)
}

function tthread() {
  t reply $(t tl -l $TWITTER_WHOAMI | head -n1 | first) $@
}
# }}}

# Geeknote {{{
alias gn=geeknote
alias gnn='gn notebook-list'
alias gnt='gn tag-list'
alias gnf='gn find'
gnc() {
  gn create --title $1 --content '' &&
    gn find --count=1 "$1"
    gn edit 1
}
alias gne='gn edit'
# }}}

# Systemd aliases {{{
alias rnc='sudo systemctl restart $(systemctl | grep netctl-auto | sed -s "s/\\s.*$//")'
alias rvpn='sudo systemctl restart openvpn@bldr-dev openvpn@lsvl-dev'
alias ift='sudo iftop -i wlp3s0'
# }}}

# Misc aliases {{{
alias asdfghjkl='echo "Having some trouble?"'
alias asdf='asdfghjkl'
alias asdflkj='asdf'
alias xmm='xmodmap ~/.Xmodmap'
alias bak='~/bin/backup.sh'

function fw() { # fix white
  local substitution
  local substitution='s/\x1b\[90m/\x1b[92m/g'
  $@ > >(perl -pe "$substitution") 2> >(perl -pe "$substitution" 1>&2)
}
# }}}

# Grep options {{{
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS
export GREP_OPTIONS=
# }}}

# Keyboard backlight {{{

KEYBOARD_BRIGHTNESS_FILE='/sys/devices/platform/applesmc.768/leds/smc::kbd_backlight/brightness'

setkbd() {
  echo $1 | sudo tee $KEYBOARD_BRIGHTNESS_FILE
}

kbdup() {
  curr=$(< $KEYBOARD_BRIGHTNESS_FILE)
  echo $(( $curr + 15 )) | sudo tee $KEYBOARD_BRIGHTNESS_FILE
}

kbdup() {
  curr=$(< $KEYBOARD_BRIGHTNESS_FILE)
  echo $(( $curr - 15 )) | sudo tee $KEYBOARD_BRIGHTNESS_FILE
}

# }}}

[ -f ./.localrc ] && source ./.localrc

source ~/.fzf.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval "$(thefuck --alias)"

export PGHOST=localhost PGUSER=nomi # KAFKA_ENABLED=false

# ssh-agent {{{
eval $(ssh-agent)
ssh-add
ssh-add ~/.ssh/id_rsa.big
# }}}

alias http='http --style solarized'

alsi -n -u

