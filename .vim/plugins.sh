#!/bin/bash

# make sure directories are present
mkdir -p ~/.vim/autoload ~/.vim/bundle

# install pathogen
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# change to plugin dir
cd ~/.vim/bundle

# install vim fugitive
git clone git://github.com/tpope/vim-fugitive.git

# install vim surrond
git clone git://github.com/tpope/vim-surround.git

# install lightline
git clone https://github.com/itchyny/lightline.vim

# install typescript-vim
git clone https://github.com/leafgarland/typescript-vim.git

# install syntastic
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

# update vim helptags
vim -u NONE -c "Helptags" -c q
