ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

alias gs='git status'
alias grp="grep --exclude-dir=.git -iR"
alias zrc="vim ~/.zshrc; source ~/.zshrc"

plugins=(git fasd)

export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin
export PYTHONSTARTUP=$HOME/.pythonrc
export DYLD_INSERT_LIBRARIES="${HOME}/stderred/build/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"

######## ENV DEPENDANT LOGIC ##########
source $HOME/.envrc

if [[ $WORK == true ]] ; then
	if [[ $VIRTUAL == false ]] ; then
		plugins+=(vagrant)
		export PATH=$HOME/ansible/bin:$PATH
		export PYTHONPATH=$HOME/ansible/lib:$HOME/FuelSDK-Python:$HOME/Tryolabs/lively
		export ANSIBLE_LIBRARY=$HOME/ansible/library
		export MANPATH=$HOME/ansible/docs/man:
		alias vsd="vagrant ssh dev"

		function update_box() {
			ansible-playbook -i hosts_onebox site_onebox.yml --limit=vagrantdev
		}

		function load_fixtures() {
			ansible-playbook -i hosts_onebox extra-playbooks/onebox/load_fixture.yml --limit=vagrantdev
		}

		function migrate() {
			python manage.py schemamigration core --settings=lively.settings_gunicorn --auto
		}
	fi
fi
if [[ $PERSONAL == true ]] ; then
	export PATH=$PATH:$HOME/.rvm/bin:$HOME/chrome
	export GOPATH=$HOME/gocode
fi
######## ENV DEPENDANT LOGIC ##########

source $ZSH/oh-my-zsh.sh

RPROMPT=%(?..[%?] )

function toggleLight() {
	if [[ $COLOR_THEME == "Solarized Dark" ]] ; then
		export COLOR_THEME="Solarized Light"
	else
		export COLOR_THEME="Solarized Dark"
	fi

	unstderred
	osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$COLOR_THEME\""
	stderred
}

function unstderred() {
	unset DYLD_INSERT_LIBRARIES
}

function stderred() {
	export DYLD_INSERT_LIBRARIES="${HOME}/stderred/build/libstderred.dylib"
}

function getTheme() {
	unstderred
	COLOR_THEME=`osascript -e "tell application \"Terminal\" to get the name of current settings of front window"`
	export COLOR_THEME="$COLOR_THEME"
	stderred
}

getTheme

stderred
