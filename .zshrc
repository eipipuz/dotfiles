ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

fpath=(~/dotfiles/functions $fpath)

alias gpo='gp origin'
alias agp="ag --python"
alias ags="ag --sql"
alias agjs="ag --js"
alias aga="ag --java --ignore-dir build"
alias agg="ag --go --ignore-dir vendor"
alias gs='git status'
alias guc="git reset --soft HEAD~1"
alias gam="git commit -v -a --amend"
alias gne="git commit -v -a --amend --no-edit"
alias grbom="grb origin/master"
alias grbod="grb origin/development"
alias gsum="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(color:cyan)%(authorname)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias zrc="vim ~/.zshrc; source ~/.zshrc"
alias tdm="osascript ~/DarkModeToggle.applescript"

plugins=(git fasd osx ag heroku)

export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PYTHONSTARTUP=$HOME/.pythonrc
export PYTHONDONTWRITEBYTECODE=True
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'
export ANDROID_HOME="/Users/GuillermoAlcantara/Library/Android/sdk"
export PATH=$PATH:/usr/local/go/bin

function set_brew() {
  brew install fasd fzf git ruby tig vim the_silver_searcher
}

source $ZSH/oh-my-zsh.sh

RPROMPT=%(?..[%?] ) # Print return code if not 0

function fa() {
  gf | fzf -m --query="$1" | xargs git add
}

function gbc() {
  gco -b $1 origin/master
}

function gpod() {
  gpo $1:master
  gpo :$1
  grbom
  gbd $1
}

function gpof() {
  if [ -z "$1" ]; then
    currentBranch=`git branch | grep "*" | cut -c 3-`
    gpo $currentBranch -f
  else
    gpo $1 -f
  fi
}

function fwdPort() {
  cat ~/port_fwd.conf| sudo pfctl -ef -
}
