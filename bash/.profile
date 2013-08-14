

##### SET BASH ENV VARS ################################
#TERM=rxvt
TERM=xterm-color
#[[ $TERM == "screen" ]] && export -p TERM="screen-256color"
umask 022
export HISTFILE=~/.bash_history
export HISTSIZE=200000;
export HISTCONTROL=erasedups
shopt -s histappend
PROMPT_COMMAND="history -a"
#PROMPT_COMMAND="$PROMPT_COMMAND;history -a"
export gnarleyHostName=`hostname | cut -d\.  -f1`



##### SET PATH #########################################
export PATH=$HOME
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/X11R6/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/opt/vim/bin
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:/opt/local/sbin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/matt_crampton_unix_env/bin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin


export MANPATH=$MANPATH:/usr/share/man
export MANPATH=$MANPATH:/usr/local/share/man
export JAVA_HOME=/usr/local/bin/java
export SVN_EDITOR="/usr/bin/vim"


#### ALIASES ###########################################
alias unixEnv="cd ~/matt_crampton_unix_env"
alias ll=gnarleyDir
alias dird=gnarleyListDirs
alias dir=gnarleyDir
alias cls="clear"
alias cd..="cd .."
alias h="gnarleyHistory"
alias c="cd"
alias d="cd"
alias cp="cp -v"
alias mv="mv -v"
alias vi="vim -p"
alias ci="vi"
alias avn="svn"
alias rm="rm -v"
alias gnarleyFind="export LANG=C; find . | grep -v svn-base | grep -i $1"
alias gnarleygrep="gnarleyGrep"


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



#### UTIL FUNCTIONS ####################################

function svnupdryrun
{
	svn merge --dry-run -r BASE:HEAD .
}

function svns
{
	svn stat
}

function svnDiff
{
	select FILENAME in $(svn stat | grep -v '?' | cut -c 3-);
	do
	     #echo "You picked $FILENAME ($REPLY)"
	     svn diff $FILENAME
	     break
	done
}

function checkHTTPStatusForURL
{
	curl --write-out %{http_code} --silent --output /dev/null $1
	echo ""
}

function watchAccess
{
	TCOLS=`tput cols`
	LASTW=`echo "$TCOLS - 40" | bc`

	if which unbuffer
	then
		sudo tailf /var/log/nginx/access.log | unbuffer -p awk -v lastw=$LASTW -f ~/matt_crampton_unix_env/awk/loadBalancerAccessLogTail.awk
	else
		sudo tailf /var/log/nginx/access.log | cut -c -$TCOLS
	fi
}

function watchAccessFE
{
	TCOLS=`tput cols`
	LASTW=20

	if which unbuffer
	then
		sudo tailf /var/log/nginx/access.log | unbuffer -p awk -v lastw=$LASTW -f ~/matt_crampton_unix_env/awk/accessLogTail.awk
	else
		sudo tailf /var/log/nginx/access.log | cut -c -$TCOLS
	fi
}

function watchPHPErrorsW
{
	if which unbuffer
		then sudo tail -f /var/log/nginx/error.log | unbuffer -p awk -v term_cols="10000" -f ~/matt_crampton_unix_env/awk/logTail.awk
	else
		sudo tail -f /var/log/nginx/error.log
	fi
}

function watchPHPErrors
{
	TERM_COLS=`tput cols`
	if which unbuffer
		then sudo tail -f /var/log/nginx/error.log | unbuffer -p awk -v term_cols="$TERM_COLS" -f ~/matt_crampton_unix_env/awk/logTail.awk
	else
		sudo tail -f /var/log/nginx/error.log
	fi
}
		

function watchLogs
{
        sudo multitail  \
        -I /var/log/auth.log  \
        -I /var/log/daemon.log  \
        -I /var/log/php5-fpm.log  \
        -I /var/log/nginx/error.log  \
        -I /var/log/syslog
}


function gnarleyGrepC
{
	query=`echo $1 | sed -e "s| |\ |g"`
	export LANG=C; find . | egrep -vi ".jpg|.gif|.png|.swf" | xargs grep -ci "$query" 2>&1  | egrep -v ".svn|No such file or directory|FreeBSD.6|\:0"
}

function gnarleyGrepCase
{
	query=`echo $1 | sed -e "s| |\ |g"`
	export LANG=C; find . | egrep -vi ".jpg|.gif|.png|.swf" | xargs grep "$query" 2>&1 | sed -e "s|\t||g" | egrep -v ".svn|No such file or directory|FreeBSD.6|Binary file"
}

function gnarleyGrep
{
	query=`echo $1 | sed -e "s| |\ |g"`
	export LANG=C; find . | egrep -vi ".jpg|.gif|.png|.swf" | xargs grep -i "$query" 2>&1 | sed -e "s|\t||g" | egrep -v ".svn|No such file or directory|FreeBSD.6|Binary file"
}

function gnarleyUnixEnvStatus
{
	echo
	echo Checking ~/matt_crampton_unix_env
	cd ~/matt_crampton_unix_env
	git status
	cd -

	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		echo
		echo Checking ~/matt_crampton_private_unix_env
		cd ~/matt_crampton_private_unix_env
		git status
		cd -
	fi
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

function gnarleyUpdate
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

	#### If matt's private env is present ###############
	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		gnarleyUpdatePrivateConf
	fi

}

function gnarleyHistory
{
	if [ "$1" == "" ]
	then
		history
	else
		history | grep "$1"
	fi
}

function gnarleyListDirs
{
	if [ "$OSTYPE" = "linux-gnu" ] ; then
		ls -AlFhGd -- */
	elif [ "$OSTYPE" = "darwin12" ] ; then
		ls -AlFhGd -- */
	else
		ls -AlFhGd -- */
	fi
}

function gnarleyDir
{
	dirCommand=""
	if [ "$OSTYPE" = "linux-gnu" ] ; then
		dirCommand="ls -AlFh --color=always"
	elif [ "$OSTYPE" = "darwin12" ] ; then
		dirCommand="ls -AlFhG"
	else
		dirCommand="ls -AlFh"
	fi

	grepCommand=""
	if [ "$1" != "" ]
	then
		if [ "$OSTYPE" = "linux-gnu" ] ; then
			grepCommand="| grep -i $1"
		elif [ "$OSTYPE" = "darwin12" ] ; then
			grepCommand="| grep -i --colour=always $1"
		else
			grepCommand="| grep -i $1"
		fi
	fi

	dirCommand+=" $grepCommand "
	eval $dirCommand
}

function gnarleyCheckHTTPStatusHistory
{
	sudo tac /var/log/nginx/access.log | head -n 50000 | awk '{ print $9 }' | sort | uniq -c
}

function command_exists
{
	type "$1" &> /dev/null ;
}

function gnarleyDirClean
{
	echo "Are you sure you want to delete ._* and .DS_Store files? (y/N)"
	read cleanDIR;

	if [ "$cleanDIR" = "y" -o "$cleanDIR" = "Y" ]
	then
		find . -name "svn*.tmp" -print | xargs rm
		find . -name "._*" -print | xargs rm
		find . -name ".DS_Store" -print | xargs rm
		echo "Done"
	fi
}


export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]]\[\e[32m\] \w/\[\e[0m\]"

unameString=`uname -a`

## DOES TMUX AND SCREEN CHECKING #############################
if command_exists tmux ; then
	if [ ! -n "$TMUX" ]; then
		if [ `tmux list-sessions | wc -l` -gt 0 ]; then	
			echo ""
			echo "----------"
			echo "There are open TMUX sessions on this box..."
			tmux list-sessions
			echo "run 'tmux attach' to re-attach"
			echo "----------"
			echo ""
		fi
	fi
fi

if command_exists screen ; then
	if [ "$WINDOW" != "" ]; then
		export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName:[SC:$WINDOW]\[\e[0m\]]\[\e[32m\] \w/\[\e[0m\]"
	else
		screenCheck=`screen -list | grep "No Sockets" > /dev/null; echo $?`
		if [ "$screenCheck" == "1" ]; then
			echo ""
			echo "----------"
			echo "There are open SCREEN sessions on this box..."
			screen -list
			echo "run 'screen -x' to re-attach"
			echo "----------"
			echo ""
		fi
	fi
fi


#Echos status to screen
echo -n -e "\033]0;$gnarleyHostName\007"

