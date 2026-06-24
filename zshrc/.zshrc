# path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# add the local and homebrew bin folders to $PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin:$PATH"

# java path
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# config python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$HOME/.virtualenvs/venv/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.virtualenvs/venv/bin/virtualenv
source $HOME/.virtualenvs/venv/bin/virtualenvwrapper.sh

# add this to solve warnings from zsh-syntax-highlighting plugin
zle -N menu-search
zle -N recent-paths

# zsh theme
DEFAULT_USER=`whoami`
ZSH_THEME="agnoster"

# config zsh plugins
plugins=(git vscode tmux z zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# completion
autoload -Uz compinit
if [[ -n $HOME/.cache/zsh/zcompdump-$ZSH_VERSION ]]; then
	compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
else
	compinit -C
fi

# config key bindings
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# config zsh history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# config fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/go/bin
