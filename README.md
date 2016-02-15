Development Environment
===========================
Ansible scripts to configure a box with a development environment based on
vim, tmux, and zsh

# Usage
Install ansible on the host and run:
 `ansible-playbook devbox.yml -i hosts_vagrant -u vagrant -k` (for example)

# Offline Install
By setting `package_env: true` in `group_vars/all/vars.yml`, the downloaded
source tarballs and vim plugin bundles (contents of `~/.vim`) will be copied
and archived in `~/dev-env/dev-env.tar.gz`. That tarball (along with this
repository) can then be used to install the development environment on a box
without Internet access by setting `offline: true` and copying `dev-env.tar.gz`
to `roles/offline/files`. Note that the box must have access to a local yum
mirror to install dependencies. The box must also have Ansible installed.

# Dotfiles
The dotfiles for vim, tmux, zsh, and git are kept in their own
[dotfiles](https://github.com/arw180/dotfiles) repository. There are a few
reasons for this:

First, decoupling the dotfiles from these Ansible scripts allows you to use GNU
Stow to manage your dotfiles in a simple way: http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

Related to the first point, you may be using this same (or similar) dev
environment on a machine that isn't provisioned using these Ansible
scripts (a MacBook where vim, tmux, zsh, etc are installed via `homebrew`,
for example). It is advantageous to keep the two resources separate in this
case.

# Details
Complete tools list:
* git
* vim (w/ Vundle)
* tmux (w/ tmux-resurrect)
* zsh (w/ oh-my-zsh)
* htop
* GNU stow

GNU Stow is used to install the applications above into `/usr/local/stow`, thus
keeping them separated from system installs.

`~/dev-env` contains supporting resources such as oh-my-zsh plugins and
    tmux-resurrect

`sudo` access to the target box is required (for yum installs of
some dependencies and using `/usr/local/stow` as the stow directory)

