# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# same effect as 'screen -R'
# tmuxr="( ( tmux ls | grep -v attached ) && tmux a ) || tmux new"
# tmuxr="tmux ls | grep -v attached | head -1 | cut -f2 -d: | xargs tmux attach -t || tmux new"

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
# if [ -f ~/vim ]; then
#    alias vi='~/vim'
# fi
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export GOPATH="$HOME/go"

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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
