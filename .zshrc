ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

fpath=(~/dotfiles/functions $fpath)

alias scr='vim ~/scrum.txt'
alias gpo='gp origin'
alias agp="ag --php"
alias ags="ag --sql"
alias agn="ag --ignore-dir dist"
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
export PYTHONSTARTUP=$HOME/.pythonrc
export PYTHONDONTWRITEBYTECODE=True
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'
export ANDROID_HOME="/Users/GuillermoAlcantara/Library/Android/sdk"
export PATH=$PATH:/usr/local/go/bin
export DB_WAREHOUSE_NAME=kiddom_warehouse

######## ENV DEPENDANT LOGIC ##########
function set_brew() {
  brew install fasd fzf git ruby tig vim the_silver_searcher
}

if [[ $PERSONAL == true ]] ; then
	export PATH=$HOME/android-sdk/build-tools/18.1.1:$HOME/android-sdk/platform-tools:$HOME/android-sdk/build-tools:$PATH
  export PATH=$HOME/chrome:$HOME/android-sdk/tools:$PATH
	export PATH=/usr/local/lib/node_modules:$PATH
else
  export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools:$PATH
fi
export PATH=/usr/local/bin:$PATH

# Used for Go development
export DYLD_FORCE_FLAT_NAMESPACE=1 # YouCompleteMe needs this or Vim crashes
export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH

######## ENV DEPENDANT LOGIC ##########

source $ZSH/oh-my-zsh.sh

RPROMPT=%(?..[%?] ) # Print return code if not 0


if [[ $TERM_PROGRAM == "Apple_Terminal" ]] ; then
	function toggleLight() {
		if [[ $COLOR_THEME == "Solarized Dark" ]] ; then
			export COLOR_THEME="Solarized Light"
		else
			export COLOR_THEME="Solarized Dark"
		fi

		osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$COLOR_THEME\""
	}

	function getTheme() {
		COLOR_THEME=`osascript -e "tell application \"Terminal\" to get the name of current settings of front window"`
		export COLOR_THEME="$COLOR_THEME"
	}

	getTheme
else
	function light() {
  	echo -e "\033]50;SetProfile=Light\a"
		export COLOR_THEME="Solarized Light"
	}

	function dark() {
		echo -e "\033]50;SetProfile=Default\a"
		export COLOR_THEME="Solarized Dark"
  }

	function sshInto() {
		echo -e "\033]50;SetProfile=$1\a"
		echo -e "\033]6;1;bg;$2;brightness;200\a"
		ssh ubuntu@$3
		if [[ $COLOR_THEME == "Solarized Dark" ]] ; then
			dark
		else
			light
		fi
		echo -e "\033]6;1;bg;*;default\a"
  }

	export COLOR_THEME="Solarized Dark"
fi

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
