#!/bin/bash

# Script to install vim, tmux, zsh, oh-my-zsh plugins, and vim plugins

# requires gcc and gcc-c++

# git requires openssl-devel, curl-devel, expat-devel, gettext-devel, zlib-devel, perl-ExtUtils-MakeMaker

# export PATH=$HOME/local/bin:$PATH

# exit on error
set -e

TMUX_VERSION=2.1
LIBEVENT_VERSION=2.0.22
NCURSES_VERSION=6.0
ZSH_VERSION=5.2
VIM_VERSION=7.4.1265
GIT_VERSION=2.7.1

INSTALL_PATH=$HOME/local

# if true, download all packages from the interwebs
DOWNLOAD=false

# TODO: check if system is Centos - need Ubuntu commands as well
# required for everything
sudo yum install gcc gcc-c++ -y
# required for git
sudo yum install openssl-devel curl-devel expat-devel gettext-devel zlib-devel perl-ExtUtils-MakeMaker -y

# create our directories
mkdir -p $HOME/local $HOME/dev_tmp
cp external/*.tar.gz $HOME/dev_tmp
cd $HOME/dev_tmp

#####################################################################
#                           Download
#####################################################################

# download source files
if [ "$DOWNLOAD" = true ] ; then
    wget -O libevent-${LIBEVENT_VERSION}.tar.gz https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz

    wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz

    wget -O ncurses-${NCURSES_VERSION}.tar.gz ftp://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

    wget -O zsh-${ZSH_VERSION}.tar.gz ftp://ftp.zsh.org/pub/zsh-5.2.tar.gz

    wget -O vim-${VIM_VERSION}.tar.gz https://github.com/vim/vim/archive/v7.4.1265.tar.gz

    wget -O git-${GIT_VERSION}.tar.gz https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz
fi

#####################################################################
#                           libevent
#####################################################################
tar xvzf libevent-${LIBEVENT_VERSION}.tar.gz
cd libevent-${LIBEVENT_VERSION}
./configure --prefix=$INSTALL_PATH --enable-shared
make
make install
cd ..

#####################################################################
#                           ncurses
#####################################################################
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
# Set cflags and c++ flags to compile with Position Independent Code enabled
export CXXFLAGS=' -fPIC'
export CFLAGS=' -fPIC'
./configure --prefix=$INSTALL_PATH --enable-shared
# compile
make
# Deduce environment information and build private terminfo tree
cd progs
./capconvert
cd ..

# make sure ncurses has compiled correctly
#./test/ncurses

# install ncurses to $HOME/local
make install
cd ..

# Tell your environment where ncurses and libevent are
export PATH=$INSTALL_PATH/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
export CFLAGS="-I$INSTALL_PATH/include -I$INSTALL_PATH/include/ncurses"
export CPPFLAGS="-I$INSTALL_PATH/include -I$INSTALL_PATH/include/ncurses" LDFLAGS="-L$INSTALL_PATH/lib"

#####################################################################
#                           vim
#####################################################################
tar xzvf vim-${VIM_VERSION}.tar.gz
cd vim-${VIM_VERSION}
./configure --prefix=$HOME/local
make
make install
cd ..

#####################################################################
#                           tmux
#####################################################################
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure --prefix=$INSTALL_PATH
make
make install
cd ..

#####################################################################
#                           zsh
#####################################################################
tar xzvf zsh-${ZSH_VERSION}.tar.gz
cd zsh-${ZSH_VERSION}
./configure --enable-shared --prefix=$INSTALL_PATH
make
make install
cd ..

#####################################################################
#                           git
#####################################################################
tar xzf git-${GIT_VERSION}.tar.gz
cd git-${GIT_VERSION}
make prefix=$HOME/local all
make prefix=$HOME/local install
cd ..

# copy vim plugins
mkdir -p ~/.vim
# install from Internet
if [ "$DOWNLOAD" = true ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
else
    tar xzvf vimbundle.tar.gz -C ~/.vim/
fi

# cleanup
rm -rf $HOME/dev_tmp

# copy dot files
cd $HOME/dev_env
cp zshrc ~/.zshrc
cp tmux.conf ~/.tmux.conf
cp gitconfig ~/.gitconfig
cp vimrc ~/.vimrc

# change default shell to zsh
# first add zsh to /etc/shells
sudo echo "$HOME/local/bin/zsh" | sudo tee -a /etc/shells
chsh -s $HOME/local/bin/zsh
# load the shell
zsh
