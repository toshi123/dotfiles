[ -z "$PS1" ] && return
# Path to your oh-my-zsh installation.
export ZSH=/Users/tsuji/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git)

# User configuration

export PATH="/Users/tsuji/.pythonbrew/bin:/Users/tsuji/.pythonbrew/pythons/Python-2.7.5/bin:/Users/toshi/perl5/perlbrew/bin:/Users/toshi/perl5/perlbrew/perls/perl-5.12.1/bin:/Users/tsuji/bin:/Users/tsuji/perl5/perlbrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/tsuji/bin:/Users/tsuji/perl5/perlbrew/bin:/usr/local/sbin:/opt/local/bin:/opt/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#


setopt prompt_subst
case "$TERM" in
    xterm*|kterm*|rxvt*)
    PROMPT='%n@%m%# '
    RPROMPT='[%(5~,%-2~/.../%2~,%~)]'
#    PROMPT=$(print "%{(J\(Be]2;%n@%m: %(J~\(B7%}$PROMPT") # title bar
    ;;
    *)
    PROMPT='%m:%c%# '
    ;;
esac

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# git stash count
function git_prompt_stash_count {
  local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [ "$COUNT" -gt 0 ]; then
    echo " ($COUNT)"
  fi
}

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color action

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    echo "%n@%m%# "
    return
  fi

  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    echo "%n@%m%# "
    return
  fi

  output=`git status --short 2> /dev/null`
  if [ -z "$output" ]; then
      res=':' # status Clean
      color='%{'${fg[blue]}'%}'
  elif [[ $output =~ "[\n]?\?\? " ]]; then
      res='?:' # Untracked
      color='%{'${fg[yellow]}'%}'
  elif [[ $output =~ "[\n]? M " ]]; then
      res='M:' # Modified
      color='%{'${fg[red]}'%}'
  else
      res='A:' # Added to commit
      color='%{'${fg[cyan]}'%}'
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  # %{...%} surrounds escape string
  echo "%n@%m %{$color%}$name$action`git_prompt_stash_count`$color %{$reset_color%}"
}

# how to use
PROMPT='`rprompt-git-current-branch`'

powerline-daemon -q
zsh /Users/tsuji/Library/Python/3.4/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
