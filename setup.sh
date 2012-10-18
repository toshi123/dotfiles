#!/bin/bash

DOT_FILES=( .zshrc .emacs .emacs.d )

for file in ${DOT_FILES[@]}
do
    if[-a $HOME/$file]; then
        echo "file already exists: $file"
    else
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done