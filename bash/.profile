

##### SET BASH ENV VARS ################################
#TERM=rxvt
TERM=xterm-color
#[[ $TERM == "screen" ]] && export -p TERM="screen-256color"
umask 022
export HISTFILE=~/.bash_history
export HISTSIZE=200000;
export HISTCONTROL=erasedups
shopt -s histappend
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
alias unix=unixEnv
alias bin="cd ~/matt_crampton_unix_env/bin"
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
alias gnarleygrep="gnarleyGrep"
alias killssh="sudo killall -9 ssh"
alias killAllSSH=killssh


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


export GNARLEYGREPFILTER="node_modules|PHPPowerPoint|PHPExcel|aws-sdk|js-concat|css-min|js-min|.git|.svn|.jpg|.gif|.png|.swf|tags\'"

function gnarleyGrepC
{
	query=`echo $1 | sed -e "s| |\ |g"`
	export LANG=C; find . -type f | egrep -vi "$GNARLEYGREPFILTER" | xargs grep -ci "$query" 2>&1  | egrep -v ".svn|No such file or directory|FreeBSD.6|\:0"
}

function gnarleyGrepCase
{
	query=`echo $1 | sed -e "s| |\ |g"`
	export LANG=C; find . -type f | egrep -vi "$GNARLEYGREPFILTER" | xargs grep "$query" 2>&1 | sed -e "s|\t||g" | egrep -v ".svn|No such file or directory|FreeBSD.6|Binary file"
}

function gnarleyGrep
{
	#OLD 2013-9-23
	#query=`echo $1 | sed -e "s| |\ |g"`
	#export LANG=C; find . -type f | egrep -vi "$GNARLEYGREPFILTER" | xargs grep -i "$query" 2>&1 | sed -e "s|\t||g" | egrep -v ".svn|No such file or directory|FreeBSD.6|Binary file"

	export LANG=C
	QUERY=`echo $1 | sed -e "s| |\ |g"`
	FILES="$(find -L . -type f)"
	COLUMNS=$(tput cols)
	echo "$FILES" | while read FILE; do
		FILENAME=`echo $FILE | egrep -vi "$GNARLEYGREPFILTER"`
		if [ ! -z "$FILENAME" ]
		then
			RESULT=`grep -i "$QUERY" "$FILE"`
			if [ ! -z "$RESULT" ]
			then
				while IFS= read -r line
				do
					echo "[$FILE] $line" | cut -c -$COLUMNS
				done <<< "$RESULT"
			fi
		fi
	done
}

function gnarleyGitPush
{
	echo
	echo pushing matt_crampton_unix_env
	cd ~/matt_crampton_unix_env
	git push
	cd -

	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		gnarleyGitPrivatePush
	fi
}

function gnarleyGitCommit
{
	gnarleyGitPublicStatus
	#echo ""
	#echo "Are you sure you want to run git commit -a for matt_crampton_unix_env?"
	#echo "(y/N)"
	#read YESORNO;

	#if [ "$YESORNO" = "y" -o "$YESORNO" = "Y" ]
	#then
		cd ~/matt_crampton_unix_env
		git commit -a
		cd -
	#fi

	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		gnarleyGitPrivateCommit
	fi
}

function gnarleyGitStatus
{
	gnarleyGitPublicStatus

	if [ -f ~/matt_crampton_private_unix_env/bash/.profile.PRIVATE ]
	then
		gnarleyGitPrivateStatus
	fi
}

function gnarleyGitPublicStatus
{
	echo
	echo Checking ~/matt_crampton_unix_env
	cd ~/matt_crampton_unix_env
	git status
	cd -
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

function gnarleyCtags
{
	if command_exists ctags ; then

		#Checks if there is a newer version of ctags
		#installed via brew on osx, otherwise uses standard one
		BREWCTAGS="`brew --prefix`/bin/ctags"
		if [ -f $BREWCTAGS ]
		then
			$BREWCTAGS $*
		else
			ctags $*
		fi

	fi
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

function generateGitBashData
{
	# * unstaged
	# + staged
	# $ stashed
	# % untracked files
	# < indicates you are behind
	# > indicates you are ahead
	# <> deverged

	declare -f -F __git_ps1 > /dev/null
	if [ $? -eq 0 ]
	then
		GITPS1="$(__git_ps1 "%s")"
		if [[ -z "$GITPS1" ]]
		then
			echo ""
		else
			GITPS1="${GITPS1//master/M}"
			GITPS1="${GITPS1//=/}"
			GITPS1="${GITPS1// /}"
			echo "|git:$GITPS1"
		fi
	else 
		echo ""
	fi
}

function setPromptCommand
{
	export PROMPT_COMMAND="setPS1; history -a"
	#PROMPT_COMMAND="$PROMPT_COMMAND;history -a"
}

function setPS1
{
	export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]`generateGitBashData`]\[\e[32m\] \w/\[\e[0m\]"
}

setPromptCommand
setPS1

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


#Echos status to screen
echo -n -e "\033]0;$gnarleyHostName\007"

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

