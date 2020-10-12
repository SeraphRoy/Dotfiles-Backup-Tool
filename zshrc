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

# ------------------- end of necessary installations ------------------------


# ------------------ custom functions ----------------------

stress() {
   while $@; do :; done
}

gzip64() {
    base64 --decode <<<$@ | gzip -cd
}

escape() {
    python3 -c "import json; haha = input('Paste your string below:\n\n'); print('\n' + json.dumps(haha))"
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

export ONI_NEOVIM_PATH=$(which nvim)
export EDITOR=vim
alias bb="brazil-build"
alias bbs="brazil-build server"
alias b="brazil"
alias grep='grep -n --color=always'
# alias vi='vim'
export VISUAL=vim
if hash drop 2>/dev/null
then
    alias vi='drop'
    # export VISUAL=drop
else
    alias vi='nvim'
    if [ -x "$(which nvim)" ]; then
        alias vi='nvim'
    else
        alias vi='vim'
    fi
    # export VISUAL=vim
fi
export EDITOR="$VISUAL"
alias findp="ps aux | grep"
alias ku="kubectl"

export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$HOME/.toolbox/bin:$PATH
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.toolbox/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export LANG=en_US.UTF-8
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

case "$(uname -s)" in

   Darwin)
     #echo 'Mac OS X'
     alias wifi_restart="networksetup -setairportpower Wi-Fi off && networksetup -setairportpower Wi-Fi on"
     ;;
   Linux)
    #echo 'Linux'
    alias vim='/apollo/env/envImprovement/bin/vim'
    alias register_with_aaa="/apollo/env/AAAWorkspaceSupport/bin/register_with_aaa.py"
    alias bb="brazil-build"
    alias bbs="brazil-build server"
    alias b="brazil"
    export PATH=/apollo/env/envImprovement/bin:$PATH
    export JAVA_HOME=/usr/lib/jvm/amazon-openjdk-8
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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ------------------ end of general zsh settings ----------------------


# ------------------- antigen plugins ------------------------

source "$ANTIGEN"
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
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

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Geneate RDE autocompletion.
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
