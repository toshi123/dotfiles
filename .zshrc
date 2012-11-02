
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
        export SVN_EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        export PATH=/Users/tsuji/bin:/opt/local/bin:/opt/local/sbin/:$PATH
        export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
        source $HOME/perl5/perlbrew/etc/bashrc
        export PERL_CPANM_OPT="--local-lib=~/extlib"
        export PERL5LIB="$HOME/extlib/lib/perl5:$HOME/extlib/lib/perl5/i386-freebsd-64int:$PERL5LIB"
        export DATAPATH=/Users/tsuji/Data/RNAstructure/data_tables/
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

        alias java='java -cp /Users/tsuji/Dropbox/eclipse/bin/allsvn.jar'
        alias ls='ls -GwF'
        alias ll='ls -GwFlat'
        export LSCOLORS=exfxcxdxbxegedabagacex
        alias emacs='~/emacs-23.2/nextstep/Emacs.app/Contents/MacOS/Emacs -nw'
        alias gw='ssh -Y gw.hgc.jp'
        ;;
linux*)
        export SVN_EDITOR=/usr/bin/vim
        export PATH=/home/tsuji/ViennaRNA/bin:/home/tsuji/ViennaRNA/ViennaRNA/bin:/home/tsuji/.gem/ruby/1.8/bin:/home/tsuji/bin:/home/tsuji/local/bin:/opt/local/bin:/opt/local/sbin/:$PATH
        export PERL5LIB=/home/tsuji/local/lib:/home/tsuji/local/lib/site_lib
        export MANPATH=/opt/local/man:$MANPATH
        export LANG=ja_JP.UTF-8
        export BLASTDB=/usr/local/db/entity/uniprot-blast.1
        
        alias java='/usr/local/package/java/current6/bin/java -cp /home/tsuji/java/allsvn.jar'
        alias emacs='/usr/local/bin/emacs-23.2 -nw'
        alias l='/bin/ls --color=auto'
        alias ls='/bin/ls -laF --color=auto'
        alias ll='/bin/ls -laFt --color=auto'
        export LSCOLORS=exfxcxdxbxegedabagacex

        ;;
esac


alias sshmac='ssh 202.175.149.179'

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
# あたりを見て適当に設定。

# 補完強化
autoload -U compinit
compinit

# cdを強くする。
# cd しただけで自動的に pushd する
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# ^で､cd ..
#function cdup() {
#  echo
#  cd ..
#  zle reset-prompt
#}
#zle -N cdup
#bindkey '\^' cdup
# cd をしたときにlsを実行する
#function chpwd() { ll }

# グローバルエイリアスで | (パイプ)いらず
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head -n 50'
alias -g T='| tail'
alias -g W='| wc -l'
alias -g H30='| head -n 30'

# キーバインドの選択
# export EDITOR=vim とかしていると
# 勝手にvi風になるので、明示的に指定する
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

# screenでウインドウの名前にコマンドを反映させるための仕掛け
preexec () {
    if [ $TERM = "screen" ]; then
        1="$1 " # deprecated.
        echo -ne "\ek${${(s: :)1}[0]}\e\\"
    fi
  }

PATH=${PATH}:/opt/local/bin

case "$OSTYPE" in
linux*)
        eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
        ;;
esac

