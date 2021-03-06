##### SET BASH ENV VARS ################################
#TERM=rxvt
#TERM=xterm-color
TERM=xterm-256color
#[[ $TERM == "screen" ]] && export -p TERM="screen-256color"
umask 022
export HISTFILE=~/.bash_history
export HISTSIZE=200000;
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=/usr/local/bin/nvim
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/local/bin/vim

shopt -s histappend
export gnarleyHostName=`hostname | cut -d\.  -f1`
#export gnarleyHostName="MACBOOKPRO"
#export gnarleyHostName="VIRTUALBOX"

# bind '"\e[A":history-search-backward'
# bind '"\e[A":history-search-backward'

##### SET PATH #########################################
export PATH=$HOME
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/X11R6/bin
# export PATH=$PATH:/opt/vim/bin
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:/opt/local/sbin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/matt_crampton_unix_env/bin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin
export PATH=$PATH:$HOME/Library/Python/2.7/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin


export MANPATH=$MANPATH:/usr/share/man
export MANPATH=$MANPATH:/usr/local/share/man
export JAVA_HOME=/usr/local/bin/java
# export SVN_EDITOR="/usr/bin/vim"


#### ALIASES ###########################################
alias unixEnv="cd ~/matt_crampton_unix_env"
alias unix=unixEnv
alias bin="cd ~/matt_crampton_unix_env/bin"
alias ll=gnarleyDir
alias dirs="ls -alFSr"
alias dird="ls -AlFhGtr"
alias ddir="ls -alF | grep drw"
alias dir=gnarleyDir
alias ir=gnarleyDir
alias diur=gnarleyDir
alias cls="clear"
alias c="clear"
alias cd..="cd .."
alias h="gnarleyHistory"
alias d="dir"
alias cp="cp -v"
alias mv="mv -v"
# alias vi="vim -p"
alias nvim="gnarleyVim"
alias vim="gnarleyVim"
alias vi="gnarleyVim"
alias ci="gnarleyVim"
alias avn="svn"
#alias rm="rm -v"
alias gnarleygrep="gnarleyGrep"
alias gnarleygrpe="gnarleyGrep"
alias gnarleyGrpe="gnarleyGrep"
alias killssh="sudo killall -9 ssh"
alias killAllSSH=killssh
alias desktop="cd ~/Desktop/"

alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi



###### use Matt's private unix env stuff ##
if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
then
	source ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE
fi

# ADD GIT completion stuff
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]
then
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWSTASHSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM="auto"
	source /usr/local/git/contrib/completion/git-completion.bash
fi



#### UTIL FUNCTIONS ####################################
function pcopy
{
	pwd | pbcopy
}

function tmuxrc
{
	vi ~/.tmux.conf
}

function nvimrc
{
	cd ~/.config/nvim
	vi init.vim
	cd -
}

# function vimrc
# {
	# cd ~/.vim
	# vi ~/.vimrc
	# cd -
# }

function cdf
{
    FOUND_FILE=`find . | grep -i "$1" | egrep -v "Archived Notes|venv|node_modules|pycache|DashboardNavbar" | fzf`
    #FOUND_FILE=`find . | grep -i "$1" | egrep -v "Archived Notes|venv|node_modules|pycache|DashboardNavbar" | head -n 1`
    echo "Found: $FOUND_FILE"
    if [ ! -d "$FOUND_FILE" ]; then
        FOUND_FILE=$(dirname "${FOUND_FILE}")
    fi
    echo "CDing to $FOUND_FILE"
    cd "$FOUND_FILE"
    gnarleyDir
}

function gnarleyFind
{
	find . | grep -i "$1"
	#alias gnarleyFind='export LANG=C; find . | grep -i "$1"'
}

function gitClean
{
	echo ""
	echo "Are you sure you want to remove ALL changes?"
	echo ">git reset --hard"
	echo ">git clean -f -d"
	echo "(y/N)"
	read YESORNO;

	if [ "$YESORNO" = "y" -o "$YESORNO" = "Y" ]
	then
		git reset --hard
		git clean -f -d
	fi
}

function gnarleyValidateJSON
{
	if [ -f $1 ]
	then
		python -m json.tool < $1
	else
		echo pass a json file to this function to validate it.  if
		echo it pretty prints out the json, it worked!
	fi
}

function gnarleyDiffMerge
{
	~/matt_crampton_unix_env/python/gnarleyDiffMerge.py $1 $2
}

export GNARLEYGREPFILTER="node_modules|PHPPowerPoint|PHPExcel|aws-sdk|js-concat|css-min|js-min|.git|.svn|.jpg|.gif|.png|.swf|tags\'"

function gnarleyGrepC
{
	# query=`echo $1 | sed -e "s| |\ |g"`
	# export LANG=C; find . -type f | egrep -vi "$GNARLEYGREPFILTER" | xargs grep -ci "$query" 2>&1  | egrep -v ".svn|No such file or directory|FreeBSD.6|\:0"
    grep -rInHc "$@" . | grep -v ":0"
}

function gnarleyGrepV
{
    # Fixed spaces in filenames
    nvim -p "`gnarleyGrep "$@" | cut -d\: -f1 | sort | uniq`"
}

function gnarleyGrep
{
	# query=`echo $1 | sed -e "s| |\ |g"`
	# export LANG=C;
	# TCOLS=`tput cols`
    # grep -r "$query" * | cut -c -$TCOLS
    grep -rInHi --exclude-dir={_site,.mypy_cache,venv,node_modules,.git,build} "$@" .
    # echo "works"
}

function gnarleyEdit
{
	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		vi -p ~/matt_crampton_unix_env/bash/.profile ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE
		source ~/matt_crampton_unix_env/bash/.profile
		source ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE
	else
		vi ~/matt_crampton_unix_env/bash/.profile
		source ~/matt_crampton_unix_env/bash/.profile
	fi
}

function gnarleyGitUpdate
{
	echo "Updating conf"
	cd ~/matt_crampton_unix_env
	git pull
	source ~/matt_crampton_unix_env/bash/.profile

	if [ -f ~/.subversion/config ];
	then
		grep 'svnVimDiff' ~/.subversion/config -q
		if [ $? -ne 0 ] ; then
			echo ""
			echo ""
			echo "-----------------------"
			echo "Add the following lines to your ~/.subversion/config"
			echo "[helpers]"
			echo "diff-cmd = /home/<you>/svnVimDiff"
			echo "-----------------------"
			echo ""
			echo ""
		fi
	fi
	cd -

	echo "Symlinking files"
	~/matt_crampton_unix_env/bin/gnarleySymlinkUnixEnvFiles

	#### If matt's private env is present ###############
	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		gnarleyGitUpdatePrivateConf
	fi

}

function gnarleyHistory
{

	# Usage: gnarleyHistory clone api
	if [[ $# -gt 0 ]]; then
		TEMP=("history | grep" "-ie" "\"\$1\"" "")
		for (( I = 2; I <= $#; ++I )); do
			TEMP=("${TEMP[@]}" "|" "egrep" "-ie" "\"\$${I}\"")
		done
		#echo "${TEMP[@]}"
		eval "${TEMP[@]}"
    else
	 	history
	fi

	# if [ "$1" == "" ]
	# then
	# 	history
	# else
	# 	history | grep -i "$1"
	# fi
}

function gnarleyDir
{
	dirCommand=""
	if [ "$OSTYPE" = "linux-gnu" ] ; then
		dirCommand="ls -AlFh --color=always"
	elif [[ "$OSTYPE" == *"darwin"* ]] ; then
		dirCommand="ls -AlFhG"
	else
		dirCommand="ls -AlFh"
	fi

	grepCommand=""
	if [ "$1" != "" ]
	then
        grepCommand="| grep -i $1"
		# if [ "$OSTYPE" = "linux-gnu" ] ; then
			# grepCommand="| grep -i $1"
        # elif [[ "$OSTYPE" == *"darwin"* ]] ; then
			# grepCommand="| grep -i --colour=always $1"
		# else
			# grepCommand="| grep -i $1"
		# fi
        dirCommand+=" $grepCommand | more "
	fi

	eval $dirCommand
}

function command_exists
{
	type "$1" &> /dev/null ;
}

function gnarleyDirClean
{
	#echo "Are you sure you want to delete ._* and .DS_Store files? (y/N)"
	#read cleanDIR;

	#if [ "$cleanDIR" = "y" -o "$cleanDIR" = "Y" ]
	#then
	#fi

	find . -type f -name 'svn*.tmp' -exec rm -vf {} \;
	find . -type f -name '._*' -exec rm -vf {} \;
	find . -type f -name '.DS_Store' -exec rm -vf {} \;
	find . -type f -name '*.plist' -exec rm -vf {} \;
	find . -type f -name '*.pyc' -exec rm -vf {} \;
	find . -type f -name '*.*~' -exec rm -vf {} \;

	echo "Done"
}

function gitPS1Help
{
	echo "--- Files ---"
	echo " * unstaged"
	echo " + staged"
	echo " $ stashed"
	echo " % untracked files"
	echo "--- Repo ---"
	echo " = latest"
	echo " < indicates you are behind"
	echo " > indicates you are ahead"
	echo " <> deverged"
}

function generatePrettyPath
{
	#FULL_PATH=`pwd`
	FULL_PATH=`pwd | cut -d\/ -f4-`
	TRUNC_FULL_PATH=`echo $FULL_PATH | tail -c 40`
	if [ "$FULL_PATH" == "$TRUNC_FULL_PATH" ]; then
		DISPLAY_PATH="~/${FULL_PATH}"
	else
		#DISPLAY_PATH="...${TRUNC_FULL_PATH}"
		DISPLAY_PATH="~"
		array=(${FULL_PATH//\// })
		for i in "${!array[@]}"
		do
			INDEX=$((i+1))
			if [ "$INDEX" == "${#array[@]}" ]; then
				DISPLAY_PATH="$DISPLAY_PATH/${array[i]}"
			else
				if (( ${#array[i]} <= 7 )) ; then
					#echo "${#array[i]} true"
					DISPLAY_PATH="$DISPLAY_PATH/${array[i]}"
				else
					#echo "${#array[i]} false"
					FIRST=`echo ${array[i]} | head -c 1`
					LAST=`echo ${array[i]} | tail -c 2`
					TRUNC="[${FIRST}.${LAST}]"
					DISPLAY_PATH="$DISPLAY_PATH/${TRUNC}"
				fi
			fi
		done
	fi
	echo $DISPLAY_PATH
}

function generateGitBashData
{
    #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/|\1/' | awk -v len=30 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
    # git name-rev --name-only HEAD | tail -c 20 | sed -e '/^[^*]/d' -e 's/* \(.*\)/|\1/'
    # return
	# * unstaged
	# + staged
	# $ stashed
	# % untracked files
	# < indicates you are behind
	# > indicates you are ahead
	# <> deverged

	# declare -f -F __git_ps1 > /dev/null
    # GIT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
    GIT_BRANCH=$(git branch 2> /dev/null | grep \* | cut -d ' ' -f2)
    if [ -z "$GIT_BRANCH" ]
	then
        # GITPS1="${GITPS1//master/M}"
        # GITPS1="${GITPS1//=/}"
        # GITPS1="${GITPS1// /}"
        # echo "|git:$GITPS1"
		echo ""
	else 
        # echo $GIT_BRANCH
        # echo ${#GIT_BRANCH}
        if [ ${#GIT_BRANCH} -ge 25 ]
        then
            GIT_BRANCH=$(echo $GIT_BRANCH | tail -c 24)
            echo "|<$GIT_BRANCH"
        else
            echo "|$GIT_BRANCH"
        fi
	fi
}

function setPromptCommand
{
    export PROMPT_COMMAND="setPS1; history -a"
}

function setTmuxTitle
{
    export TMUX_WINDOW_TITLE=$1
}

function setPS1
{
	export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]`generateGitBashData`]\[\e[32m\] \w/\[\e[0m\]"
	if [ -n "$VIRTUAL_ENV" ]; then
		export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]`generateGitBashData`|\[\e[31;1m\]VENV\[\e[37;1m\]]\[\e[32m\] \w/\[\e[0m\]"
	fi

    # Set TMUX window title
    # if [ -n "$TMUX" ]
    # then
        # echo "yes $TMUX_WINDOW_TITLE"
        # if [ -n "$TMUX_WINDOW_TITLE" ]; then
            # tmux rename-window $TMUX_WINDOW_TITLE
        # fi
    # else
        # echo "no"
    # fi
}

function gnarleyVim
{
    #if [ -n "$TMUX" ]; then
    #    if [ `tmux list-sessions 2>&1 | grep -v "error" |  grep -v "no server running" | wc -l` -gt 0 ]; then
    #        # DISPLAY_PATH=`realpath $1 | sed -e "s|\/home\/revicon\/||g"`
    #        # tmux rename-window "vim $DISPLAY_PATH"
    #        tmux rename-window "vim"
    #    fi
    #fi
    
    # Fixed spaces in filenames
    #/usr/bin/vim -p "$@"
    /usr/local/bin/nvim -p "$@"

    # if [ -n "$TMUX" ]; then
    #     if [ `tmux list-sessions 2>&1 | grep -v "error" |  grep -v "no server running" | wc -l` -gt 0 ]; then
    #         tmux rename-window "bash"
    #     fi
    # fi
}

setPromptCommand
#setPS1

unameString=`uname -a`

## DOES TMUX AND SCREEN CHECKING #############################
if command_exists tmux ; then
	if [ ! -n "$TMUX" ]; then
		if [ `tmux list-sessions 2>&1 | grep -v "error" |  grep -v "no server running" | wc -l` -gt 0 ]; then	
			echo ""
			echo "----------"
			echo "There are open TMUX sessions on this box..."
			tmux list-sessions
			echo "run 'tmux attach' to re-attach"
			echo "----------"
			echo ""
		fi
    # else
        # tmux rename-window "              "
	fi
fi


#Echos status to screen
#echo -n -e "\033]0;$gnarleyHostName\007"

#INTTEST=0
#if [[ -t "$INTTEST" || -p /dev/stdin ]]
#then
#	curl https://api.github.com/zen
#	echo
#fi




##
# Your previous /Users/matt/.profile file was backed up as /Users/matt/.profile.macports-saved_2013-11-15_at_23:08:55
##

# MacPorts Installer addition on 2013-11-15_at_23:08:55: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

