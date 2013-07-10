ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

alias gs='git status'
alias grp="grep --exclude-dir=.git -IR"
alias zrc="vim ~/.zshrc; source ~/.zshrc"

plugins=(git fasd)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:$HOME/.rvm/bin:$HOME/chrome
export PYTHONSTARTUP=$HOME/.pythonrc
export GOPATH=$HOME/gocode

RPROMPT=%(?..[%?] )

function unstderred() {
	unset DYLD_INSERT_LIBRARIES
}

function stderred() {
	export DYLD_INSERT_LIBRARIES="${HOME}/stderred/build/libstderred.dylib"
}

stderred
