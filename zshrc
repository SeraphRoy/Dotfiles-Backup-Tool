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
   git clone https://github.com/gabrielelana/awesome-terminal-fonts $dir
   cd $dir
   ./install.sh
   cd ..
   rm -rf $dir
fi

# ------------------- end of necessary installations ------------------------


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

grepgo() {
   grep -n --include "*.go" --exclude "*test.go" --exclude-dir "test" --exclude-dir "mock" --exclude-dir "vendor" "$@"
}

stress() {
   while $@; do :; done
}

# ------------------ end of custom functions----------------------


# ------------- plugin settings that should come before the plugins ----------------

# powerlevel9k
export TERM='xterm-256color'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%H:%M \uf073 %m/%d/%y}"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

# ------------------ end of plugin settings ----------------------


# ------------------ general zsh settings ----------------------

# # same effect as 'screen -R'
# tmuxr="( ( tmux ls | grep -v attached ) && tmux a ) || tmux new"
# tmuxr="tmux ls | grep -v attached | head -1 | cut -f2 -d: | xargs tmux attach -t || tmux new"

alias lc="leetcode"

export VISUAL=vim
export ONI_NEOVIM_PATH=$(which nvim)
export EDITOR=vim
alias grep='grep -n --color=always'
alias vi='vim'
alias findp="ps aux | grep"
alias ku="kubectl"

export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$HOME/.toolbox/bin:$PATH
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export LANG=en_US.UTF-8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home

case "$(uname -s)" in

   Darwin)
     #echo 'Mac OS X'
     ;;
   Linux)
     #echo 'Linux'
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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ------------------ end of general zsh settings ----------------------


# ------------------- antigen plugins ------------------------

source "$ANTIGEN"
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle skywind3000/z.lua
# need to install nerd-fonts
# antigen theme bhilburn/powerlevel9k powerlevel9k
antigen theme romkatv/powerlevel10k
antigen apply

# ------------------- end of antigen plugins ------------------------


# ------------- plugin settings that should come after the plugins ----------------

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# --------------------- end of plugin settings ----------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# z.lua enhanced matching algorithm 
export _ZL_MATCH_MODE=1

# opam configuration
test -r /Users/yanxichen/.opam/opam-init/init.zsh && . /Users/yanxichen/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
