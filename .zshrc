ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

alias gs='git status'
alias grp="grep -IR"
alias zrc="vim ~/.zshrc; source ~/.zshrc"

plugins=(git fasd vagrant)

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/ansible/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:$HOME/.rvm/bin:$HOME/chrome
export PYTHONSTARTUP=$HOME/.pythonrc
export DYLD_INSERT_LIBRARIES="${HOME}/stderred/build/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
export PYTHONPATH=$HOME/ansible/lib:
export ANSIBLE_LIBRARY=$HOME/ansible/library
export MANPATH=$HOME/ansible/docs/man:

RPROMPT=%(?..[%?] )
