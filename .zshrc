
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
        export PATH=/Users/tsuji/bin:$HOME/perl5/perlbrew/bin:/usr/local/bin:/usr/local/sbin:$PATH
        export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
        source $HOME/perl5/perlbrew/etc/bashrc
        export PERL_CPANM_OPT="--local-lib=~/extlib"
        export PERL5LIB="$HOME/extlib/lib/perl5:$HOME/extlib/lib/perl5/i386-freebsd-64int:$PERL5LIB"
        export DATAPATH=/Users/tsuji/Data/RNAstructure/data_tables/

        alias ls='ls -GwF'
        alias ll='ls -GwFlat'
        export LSCOLORS=exfxcxdxbxegedabagacex
        source ~/.zsh.local
        ;;
linux*)

        export AMBERHOME=$HOME/local/amber12
        PATH=$AMBERHOME/bin:$HOME/local/amber12_mpi/bin:$PATH
        export SVN_EDITOR=/usr/bin/vim
        export PATH=$HOME/.gem/ruby/1.8/bin:$HOME/bin:$HOME/local/bin:/opt/local/bin:/opt/local/sbin/:$HOME/local/openmpi/bin:/opt/intel/bin:$HOME/perl5/perlbrew/bin:$PATH

        export PERL5LIB=/home/tsuji/local/lib:/home/tsuji/local/lib/site_lib
        export MANPATH=/opt/local/man:$MANPATH
        export LANG=ja_JP.UTF-8
        ulimit -s unlimited # for cafemol
        alias l='/bin/ls --color=auto'
        alias ls='/bin/ls -laF --color=auto'
        alias ll='/bin/ls -laFt --color=auto'
        export LSCOLORS=exfxcxdxbxegedabagacex
        ;;
esac

[ -f ~/Dropbox/dotfiles/.zshrc.local ] && source ~/Dropbox/dotfiles/.zshrc.local


setopt prompt_subst
case "$TERM" in
    xterm*|kterm*|rxvt*)
    PROMPT='%n@%m%# '
    RPROMPT='[%(5~,%-2~/.../%2~,%~)]'
#    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT") # title bar
    ;;
    *)
    PROMPT='%m:%c%# '
    ;;
esac


# http://d.hatena.ne.jp/mollifier/20090414/1239634907
# あたりを見て設定。

# 補完強化
autoload -U compinit
compinit

# cdを強くする。
# cd しただけで自動的に pushd する
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# グローバルエイリアスで | (パイプ)いらず
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head -n 50'
alias -g T='| tail'
alias -g W='| wc -l'
alias -g H30='| head -n 30'
alias -g P='| peco'


if [ -x "`which peco`" ]; then
  alias lll='ls -la | peco'
  alias tp='top | peco'
  alias pp='ps aux | peco'
fi

# キーバインドの選択
bindkey -e   # emacs風
# bindkey -v # vi風

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# フローコントロールを無効にする
# 今時役に立たない。むしろ邪魔
setopt no_flow_control

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 補完候補をカラー表示する
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 今入力している内容から始まるヒストリを探す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# ディレクトリ名だけでcdする
setopt auto_cd

# cdするときのパス。ここからの相対パスでも移動できるようになる
#cdpath=(${HOME} ..)

# '#' 以降をコメントとして扱う
setopt interactive_comments

# 単語として扱う文字に / を含めない。 ^W で / の前までのディレクトリ1つ分削除できる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ^]で1つ前のコマンドの最後の単語を挿入できる
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^]' insert-last-word

# cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

# antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
    source $HOME/.zsh/antigen/antigen.zsh
    antigen bundle mollifier/anyframe
    antigen apply
fi

# 文末で^dするとlist-expand (ワイルドカードをリストで展開)
# それ以外だとdelete
function _delete-char-or-list-expand() {
    if [[ -z "${RBUFFER}" ]]; then
        # the cursor is at the end of the line
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand


[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"


# Insert the following environments and aliases into your .cshrc file

# Note: Edit the strings @@_procheck_program_directory_@@ and
#       @@_aqua_program_directory_@@ below to point to the
#       directories containing the procheck and aqua executables
#       and associated data and parameter files.


# PROCHECK environments and aliases
# ---------------------------------
prodir='/Users/tsuji/Dropbox/work/mgpcm_modeling/procheck'
export prodir
alias procheck=$prodir'/procheck.scr'
alias procheck_comp=$prodir'/procheck_comp.scr'
alias procheck_nmr=$prodir'/procheck_nmr.scr'
alias proplot=$prodir'/proplot.scr'
alias proplot_comp=$prodir'/proplot_comp.scr'
alias proplot_nmr=$prodir'/proplot_nmr.scr'
alias aquapro=$prodir'/aquapro.scr'
alias gfac2pdb=$prodir'/gfac2pdb.scr'
alias viol2pdb=$prodir'/viol2pdb.scr'
alias wirplot=$prodir'/wirplot.scr'

# AQUA environment and aliases (for use with PROCHECK-NMR)
# --------------------------------------------------------
# Aliases are initialised by typing 'aqua'
#

if [ -z "$aquaroot" ]; then
   aquaroot='/Users/tsuji/Dropbox/work/mgpcm_modeling/aqua3.2'
   export aquaroot
fi

alias aqua='source $aquaroot/aqsetupi'  # This needs a SH equivalent !!!

# for virtualenvs
if [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi
