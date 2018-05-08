# ------------------- necessary installations ------------------------

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
	echo "Installing antigen ..."
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
	[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
	[ ! -f "$HOME/.z" ] && touch "$HOME/.z"
	URL="http://git.io/antigen"
	TMPFILE="/tmp/antigen.zsh"
	if [ -x "$(which curl)" ]; then
		curl -L "$URL" -o "$TMPFILE" 
	elif [ -x "$(which wget)" ]; then
		wget "$URL" -O "$TMPFILE" 
	else
		echo "ERROR: please install curl or wget before installation !!"
		exit
	fi
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "ERROR: downloading antigen.zsh ($URL) failed !!"
		exit
	fi;
	echo "move $TMPFILE to $ANTIGEN"
	mv "$TMPFILE" "$ANTIGEN"
fi

# install powerline font if not exist
if ! fc-list | grep powerline > /dev/null; then
   echo "Installing powerline font ..."
   dir="fonts"
   git clone https://github.com/powerline/fonts.git --depth=1 $dir
   cd $dir
   ./install.sh
   cd ..
   rm -rf $dir
fi

# ------------------- end of necessary installations ------------------------


# ------------------- antigen plugins ------------------------

source "$ANTIGEN"
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git
antigen bundle autojump
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

# ------------------- end of antigen plugins ------------------------


# ------------------ custom functions ----------------------

smux() {
#   if [ "X$1" = "X" ]; then
   if [ $# -eq 0 ]; then

      echo "usage: `basename $0` <host> <port>"
      return 1
   fi

   port=22
   if [ -z "$2" ]; then
      port=22
   else
      port=$2
   fi

   if [ "X$SSH_AUTH_SOCK" = "X" ]; then
      eval `ssh-agent -s`
      ssh-add $HOME/.ssh/id_rsa
   fi

   AUTOSSH_POLL=20 AUTOSSH_PORT=$(awk 'BEGIN { srand(); do r = rand()*32000; while ( r < 20000 ); printf("%d\n",r)  }' < /dev/null) autossh -p $port -t $1 "tmux -CC -u attach"
   #AUTOSSH_GATETIME=30
   #AUTOSSH_LOGFILE=$HOST.log
   #AUTOSSH_DEBUG=yes
   #AUTOSSH_PATH=/usr/local/bin/ssh
   # export AUTOSSH_POLL AUTOSSH_LOGFILE AUTOSSH_DEBUG AUTOSSH_PATH AUTOSSH_GATETIME AUTOSSH_PORT

   # -t is the ssh option to force a pseudo terminal (pty)
   # autossh -t $@ "tmux attach-session"
}

# ------------------ end of custom functions----------------------


# ------------------ plugin settings ----------------------

export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)

# ------------------ end of plugin settings ----------------------


# ------------------ general zsh settings ----------------------

# # same effect as 'screen -R'
# tmuxr="( ( tmux ls | grep -v attached ) && tmux a ) || tmux new"
# tmuxr="tmux ls | grep -v attached | head -1 | cut -f2 -d: | xargs tmux attach -t || tmux new"

# alias sshus="mosh us165 -- sh -c \"tmux attach\""
# alias sshcvp="mosh --ssh='ssh -p 10140' us165 -- sh -c \"$tmuxr\""
# alias sshr123s19="mosh --ssh='ssh -p 10140' r123s19 -- sh -c \"$tmuxr\""
# alias sshrecruit="ssh yanxichen@recruit.arista.com"

alias sshus="smux us165"
alias sshcvp="smux us165 10140"
alias sshr123s19="smux r123s19 10140"
alias sshrecruit="ssh yanxichen@recruit.arista.com"

export VISUAL=vim
export EDITOR=vim
alias grep='grep -n --color=always'
alias vi='vim'
alias findp="ps aux | grep"

if [ -x "$(command -v Art)"  ]; then
   alias grepcvp="Art grab `Art list --pool=cvp | grep free | awk '{print $2}' | head -n 1` --pool=cvp"
fi
# if [ -f ~/vim ]; then
#    alias vi='~/vim'
# fi
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export GOPATH="$HOME/go"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

export SHELL="/bin/zsh"
case "$(uname -s)" in

   Darwin)
     #echo 'Mac OS X'
     [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
     if test $(pidof clipper | wc -w) -eq 0; then
        # extra port forwarding for mosh
        # ssh -N -f us165-clipper > /dev/null 2>&1
        nohup clipper --port 9999 </dev/null >/dev/null 2>&1 &
     else
        ;
     fi
     ;;
   Linux)
     #echo 'Linux'
     [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
     ;;
   CYGWIN*|MINGW32*|MSYS*)
     #echo 'MS Windows'
     ;;

   # Add here more strings to compare
   # See correspondence table at the bottom of this answer

   *)
    #echo 'other OS' 
     ;;
esac

bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
export TERM='xterm-256color'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ------------------ end of general zsh settings ----------------------
