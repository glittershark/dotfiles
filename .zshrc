#!/usr/bin/zsh
#

source ~/.t-completion.zsh

# Compinstall {{{
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._- :]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 5
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
export PATH=~/.cabal/bin:$PATH:/usr/bin/vendor_perl:/usr/bin/core_perl:~/bin:~/npm/bin:~/.gem/ruby/2.1.0/bin:~/.gem/ruby/2.0.0/bin
# }}}

# Oh-My-Zsh {{{
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sharkparty"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git systemd jira postgres python colorize github battery archlinux git-extras vi-mode themes zsh-syntax-highlighting)

# }}}

# Zsh highlight highlighters {{{
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# }}}

# Fasd {{{
eval "$(fasd --init auto)"
alias v='f -e vim'
alias m='f -e mplayer'
# }}}

source $ZSH/oh-my-zsh.sh

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

# Force screen to use zsh
alias screen='screen -s /bin/zsh'

alias hackwiz='nethack -p wiz -r elf'

if [[ $TERM = 'rxvt-unicode' ]]; then
  export TERM=rxvt-unicode-256color
elif [[ $TERM = 'xterm' ]]; then
  export TERM=xterm-256color
fi

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
alias -- -='cd -'

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
  if ! lsblk | grep /mnt/external; then
    if ! sudo mount /mnt/external; then
      echo "External drive not plugged in"
      return 1
    fi
  fi
  mpd           &&
    mpdscribble &&
    ncmpcpp
}

# kill mp
function kmp() {
  killall ncmpcpp
  mpd --kill
  sudo umount /mnt/external
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
alias g='git'
alias gnp='git --no-pager'
# function ga() { git add "${@:-.}"; } # Add all files by default
alias ga='git add'
# Add non-whitespace changes
alias ganw='git diff -w --no-color | git apply --cached --ignore-whitespace'
alias gp='git push'
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
alias gcv='git commit --verbose'
alias gb='git branch'
alias gba='git branch -a'
alias gbg='git branch | grep'
# function gc() { git checkout "${@:-master}"; } # Checkout master by default
alias gc='git checkout'
alias gco='gc'
alias gcb='gc -b'
alias gr='git reset'
alias grh='gr --hard'
alias grhh='grh HEAD'
alias grs='gr --soft'
alias gcl='git clone'
alias gcd='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gbt='git vl branch'

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

# add a github remote by github username
function gra() {
  if (( "${#@}" != 1 )); then
    echo "Usage: gra githubuser"
    return 1;
  fi
  local repo=$(gr show -n origin | perl -ne '/Fetch URL: .*github\.com[:\/].*\/(.*)/ && print $1')
  gr add "$1" "git://github.com/$1/$repo"
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
# }}}

# adb {{{
export GNEX_IP='192.168.3.30'
alias adbcon='adb connect $GNEX_IP'
alias adbdev='adb devices'
# }}}

# Golang {{{
export GOROOT="/usr/lib/go"
export GOPATH="/home/smith/code/go"
# }}}

# Startstuff {{{
alias startcos='vboxmanage startvm COS-Test --type headless && echo 1 > /tmp/which_cos'
alias startcos2='vboxmanage startvm COS2-Test --type headless && echo 2 > /tmp/which_cos'
function swapcos() {
case $(< ~/.which_cos) in
    1)
      echo -e "\033[01;37m Switching to COS2 \033[00m"
      vboxmanage controlvm COS-Test savestate || return 1
      vboxmanage startvm COS2-Test --type headless || return 1
      rm /Library/WebServer/communityos || return 1
      ln -s /Library/WebServer/cos2/public /Library/WebServer/communityos || return 1
      echo 2 > ~/.which_cos
      ;;
    2)
      echo -e "\033[01;37m Switching to COS1 \033[00m"
      vboxmanage controlvm COS2-Test savestate || return 1
      vboxmanage startvm COS-Test --type headless || return 1
      rm /Library/WebServer/communityos || return 1
      ln -s /Library/WebServer/cos /Library/WebServer/communityos || return 1
      echo 1 > ~/.which_cos
      ;;
  esac
}
# }}}

# Tail logs {{{
alias tnotify='tail -f ~/code/notifyserver/nohup.out'
alias tfc='echo "TODO: make tfc alias"'
# }}}

# Running stuff {{{
alias rfc='[[ "$(pwd)" == "$HOME/fredchat/src/client" ]] || pushd ~/code/fredchat/src/client >/dev/null && python fredchat.py && popd >/dev/null'
alias tstaw='Xephyr -ac -br -noreset -screen 800x600 :1; DISPLAY=:1; awesome'
# }}}

# Directories {{{
alias hks='cd ~/code/hooks'
alias cos='cd ~/code/cos'
alias cos2='cd ~/code/cos2'
alias tan='cd ~/code/critical-tangent/tangent'
alias ddy='cd ~/code/digitaldirectory'
alias fcr='cd ~/code/fredchat'
alias fcc='cd ~/code/fredchat/client'
alias fcs='cd ~/code/fredchat/server'
alias dtf='cd ~/.dotfiles'
alias csc='cd ~/code/go/src/github.com/glittershark/cascade/'

export PYTHONPATH=$PYTHONPATH:~/code/fredchat
export GIT_COS_CLONE="/home/smith/code/cos"

export NODE_ENV='development'
# }}}

# SSH shortcuts {{{
alias fred='ssh Griffin@fredchat.com'
alias pi='ssh pi@192.168.1.13'
alias bulbasaur='ssh admin@192.168.56.101'
alias bulba=bulbasaur

alias fhc='ssh -p 2247 zoodle@166.78.141.131'

alias vbox='ssh vladmin@cos.dev'
alias coral='ssh vladmin@coral.vladmin.net'
alias paci='ssh vladmin@pacific.vladmin.net'
alias frog='ssh smith@frogger.vladmin.net'
alias cali='ssh vladmin@california.vladmin.net'
alias luigi='ssh vladmin@luigi.vladmin.net'
alias mario='ssh vladmin@mario.vladmin.net'
alias calculon='ssh vladmin@calculon.vladmin.net'
alias flexo='ssh vladmin@flexo.vladmin.net'
# }}}

# Editing config files {{{
alias vi='vim'
alias virc='vi ~/.zshrc && source ~/.zshrc || echo "Editing failed"'
alias vivi='vi ~/.vimrc || echo "Editing failed"'
alias vigit='vi ~/.gitconfig || echo "Editing failed"'
alias viawe='(cd ~/.config/awesome/ && gvim rc.lua)'

alias rmresolv='sudo rm /etc/resolv.conf'
# }}}

# XRandR {{{
alias workmon='xrandr --output DP-2 --pos 1440x900 --primary'
# }}}

alias py=ipython2
alias py3=ipython

alias cat=dog

alias rnc='sudo systemctl restart $(systemctl | grep netctl-auto | sed -s "s/\\s.*$//")'

# {{{
alias asdfghjkl='echo "Having some trouble?"'
alias asdf='asdfghjkl'
alias asdflkj='asdf'
# }}}

[ -f ./.fredrc ] && source ./.fredrc

# vim: set foldmethod=marker:

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
