# If not running interactively, don't do anything
[ -z "$PS1" ] && return


source ~/.profile


export NVM_DIR="/home/revicon/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
