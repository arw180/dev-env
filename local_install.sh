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
TMUX_RESURRECT_VERSION=2.4.0

# everything is install into here
INSTALL_PATH=$HOME/local
# temporary build directory (gets deleted)
TMP_DIR=$HOME/dev_tmp
# directory containing dev-env
DEV_DIR=$HOME/dev-env
# directory to store external packages. Don't change this without also changing
# zshrc and tmux.conf
EXT_DIR=$DEV_DIR/external

# if true, download all packages from the interwebs
DOWNLOAD=false

# TODO: check if system is Centos - need Ubuntu commands as well
# required for everything
sudo yum install gcc gcc-c++ unzip -y
# required for git
sudo yum install openssl-devel curl-devel expat-devel gettext-devel zlib-devel perl-ExtUtils-MakeMaker -y

# create our directories
rm -rf $TMP_DIR
mkdir -p $INSTALL_PATH $TMP_DIR
if [ "$DOWNLOAD" = false ] ; then
    cp external/*.tar.gz $TMP_DIR
fi
cd $TMP_DIR

#####################################################################
#                           Download
#####################################################################

# download source files
if [ "$DOWNLOAD" = true ] ; then
    wget -O libevent-${LIBEVENT_VERSION}.tar.gz https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz

    wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz

    wget -O ncurses-${NCURSES_VERSION}.tar.gz ftp://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

    wget -O zsh-${ZSH_VERSION}.tar.gz http://sourceforge.net/projects/zsh/files/zsh/5.2/zsh-5.2.tar.gz/download

    wget -O vim-${VIM_VERSION}.tar.gz https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz

    wget -O git-${GIT_VERSION}.tar.gz https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz

    wget -O oh-my-zsh.zip https://github.com/robbyrussell/oh-my-zsh/archive/master.zip

    wget -O tmux-resurrect-${TMUX_RESURRECT_VERSION}.tar.gz https://github.com/tmux-plugins/tmux-resurrect/archive/v${TMUX_RESURRECT_VERSION}.tar.gz
fi

#####################################################################
#                           libevent
#####################################################################
tar xvzf libevent-${LIBEVENT_VERSION}.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
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
./configure --prefix=$INSTALL_PATH
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
make prefix=$INSTALL_PATH all
make prefix=$INSTALL_PATH install
cd ..

# copy vim plugins
mkdir -p ~/.vim
if [ "$DOWNLOAD" = true ] ; then
    mkdir -p ~/.vim/bundle
    rm -rf ~/.vim/bundle/*
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
else
    tar xzvf vimbundle.tar.gz -C ~/.vim/
fi

#####################################################################
#                           oh-my-zsh
#####################################################################
unzip oh-my-zsh.zip
rm -rf $EXT_DIR/oh-my-zsh
mv oh-my-zsh-master $EXT_DIR/oh-my-zsh

#####################################################################
#                          tmux-resurrect
#####################################################################
tar xzf tmux-resurrect-${TMUX_RESURRECT_VERSION}.tar.gz
rm -rf $EXT_DIR/tmux-resurrect-${TMUX_RESURRECT_VERSION}
mv tmux-resurrect-${TMUX_RESURRECT_VERSION} $EXT_DIR

# cleanup
rm -rf $TMP_DIR

# copy dot files
cd $DEV_DIR
cp zshrc ~/.zshrc
cp tmux.conf ~/.tmux.conf
cp gitconfig ~/.gitconfig
cp vimrc ~/.vimrc

# change default shell to zsh
# first add zsh to /etc/shells
sudo echo "$INSTALL_PATH/bin/zsh" | sudo tee -a /etc/shells
# WARNING: don't want to do this more than once
chsh -s $INSTALL_PATH/bin/zsh
# load the shell
zsh
