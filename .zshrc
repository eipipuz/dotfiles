ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

alias gs='git status'
alias gpo='gp origin'
alias grp="grep --exclude=\*.{pyc,swp} --exclude-dir=.git -iR"
alias zrc="vim ~/.zshrc; source ~/.zshrc"

plugins=(git fasd)

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin
export PYTHONSTARTUP=$HOME/.pythonrc
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

######## ENV DEPENDANT LOGIC ##########
source $HOME/.envrc

if [[ $WORK == true ]] ; then
	if [[ $VIRTUAL == false ]] ; then
		plugins+=(vagrant)
		export PATH=/usr/local/share/npm/lib/node_modules/protractor/bin:$HOME/ansible/bin:/usr/local/Cellar/ruby/2.0.0-p247/bin:$PATH
		export PYTHONPATH=$HOME/ansible/lib:$HOME/FuelSDK-Python:$HOME/Tryolabs/lively
		export ANSIBLE_LIBRARY=$HOME/ansible/library
		export MANPATH=$HOME/ansible/docs/man:
		alias vsd="vagrant ssh dev"
		alias ios6sdk_install="sudo ln -s ~/iPhoneOS6.0.sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs"

		function update_box() {
			pushd /Users/memo/Tryolabs/deploy/provisioning
			ansible-playbook -i hosts_onebox site_onebox.yml --limit=vagrantdev $*
			popd
		}

		function load_fixtures() {
			pushd /Users/memo/Tryolabs/deploy/provisioning
			ansible-playbook -i hosts_onebox extra-playbooks/onebox/qa_fixture.yml --limit=vagrantdev $*
			popd
		}

		function migrate() {
			python manage.py schemamigration core --settings=lively.settings_gunicorn --auto
		}
	fi
fi
if [[ $PERSONAL == true ]] ; then
	export PATH=$HOME/android-sdk/build-tools/18.1.1/:$HOME/android-sdk/platform-tools:$HOME/android-sdk/build-tools:$PATH
	export PATH=$HOME/.rvm/gems/ruby-2.0.0-p195/bin:$HOME/.rvm/bin:$HOME/chrome:$HOME/android-sdk/tools:$PATH
	export PATH=/usr/local/lib/node_modules:$PATH
	export GOPATH=$HOME/gocode
fi
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

	alias man_box="sshInto Production red 54.215.223.59"
	alias log_box="sshInto Logistics green 50.18.222.180"
	alias ci_box="sshInto Development blue ci.mylivelydev.com"

	export COLOR_THEME="Solarized Dark"
fi

