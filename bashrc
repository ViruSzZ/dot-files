#xxxxxxxxxxxxxxxxxx
#   - ViruSzZ -   #
#xxxxxxxxxxxxxxxxxx


if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export LANG=en_US.UTF-8

###xxxxxxxxxxxxxxxxxxxxxxxxx###
##  shell opts: see bash(1)  ##
###xxxxxxxxxxxxxxxxxxxxxxxxx###
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s extglob
shopt -s histverify

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  Enable history appending instead of overwriting  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
shopt -s histappend

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  don't put duplicate lines in the history.  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=20000

set -o notify           # notify of completed background jobs immediately
ulimit -S -c 0          # disable core dumps
stty -ctlecho           # turn off control character echoing
setterm -regtabs 2      # set tab width of 4 (only works on TTY)

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  Change the window title of X terminals  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
        ;;
esac

use_color=false

safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
## Set colorful PS1 only on colorful terminals.                    ##
## dircolors --print-database uses its own built-in database       ##
## instead of using /etc/DIR_COLORS.  Try to use the external file ##
## first to take advantage of user additions.  Use internal bash   ##
## globbing instead of external grep binary.                       ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
match_lhs=""

###xxxxxxxxxxxxxxxxxxxxxxxx###
##  add my own bin to path  ##
###xxxxxxxxxxxxxxxxxxxxxxxx###
[[ -d ~/bin ]] && export PATH=~/bin:"${PATH}"

###xxxxxxxxxxxxxxxxxxxx###
##  JAVA ENV VARIABLES  ##
###xxxxxxxxxxxxxxxxxxxx###
#JAVA_HOME=/usr/share/java/bin
#CATALINA_HOME=/opt/tomcat/bin
#export JAVA_OPTS="-Djava.net.preferIPv4Stack=true"

###xxxxxxxxxxxxxxxxx###
##  Do some exports  ##
###xxxxxxxxxxxxxxxxx###
export MAILTO=m@stavrovski.net
export EDITOR=vim
export VISUAL=vim

###xxxxxxxxxxxxxxxxxxxxxxxx###
##  bash (sudo) completion  ##
###xxxxxxxxxxxxxxxxxxxxxxxx###
complete -cf sudo

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

###xxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  Less Colors for Man Pages  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxx###
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  dynamically choose which tabs load in screen  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
export SCREEN_CONF_DIR="$HOME/.screen/configs"
export SCREEN_CONF="main"

###xxxxxxxxxxxxxxxxxxxxxxxxx###
##  Source files and prompt  ##
###xxxxxxxxxxxxxxxxxxxxxxxxx###
##  '.aliases'  => Aliases   ##
##  '.prompt'   => Prompt    ##
##  '.functions => Functions ##
###xxxxxxxxxxxxxxxxxxxxxxxxx###
FILES_ARRAY=('aliases' 'login-prompt' 'functions')
for file in "${FILES_ARRAY[@]}"; do [[ -f ${HOME}/.dot/${file} ]] && source ${HOME}/.dot/${file}; done

###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
##  Try to keep environment pollution down  ##
###xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx###
unset use_color safe_term match_lhs FILES_ARRAY

#############
## Startup ##
#############
#setcolors
welcome

#Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
#export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u@\h\[\033[00m\]:$BLUEBOLD\w\[\033[00m\] \\$ "
export PS1="\n${PURPLEBOLD}# \u@\h [\t] \w\n>>\[\033[00m\] "
}
prompt