#!/bin/bash

DOT_FILES=( .zshrc .emacs .emacs.d )

for file in ${DOT_FILES[@]}
do
    if [ -a $HOME/$file ]; then
        if [ -L $HOME/$file ]; then
            echo "既にシンボリックリンクが存在します: $file"
        elif [ -d $HOME/$file ]; then
            echo "既にディレクトリが存在します: $file"
        else
            echo "既にファイルが存在します: $file"
        fi
    else
        ln -s $HOME/dotfiles/$file $HOME/$file
        echo "シンボリックリンクを貼りました: $file"
    fi
done