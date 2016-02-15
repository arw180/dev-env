Development Environment
===========================
Ansible scripts to configure a box with a development environment based on
vim, tmux, and zsh

Tested on:
* Centos 6.7 (Vagrant)
* Amazon Linux AMI (EC2 instance, RHEL 5/6 based)
* Amazon Red Hat 7.2 (EC2 instance)
* Amazon Ubuntu Server 14.04 LTS (EC2 instance)

If you are forced to use PuTTY to get a terminal to your box, you'll want to
revert to `bash` for your shell

# Usage
Install ansible on the host and run something like:
* `ansible-playbook devbox.yml -i hosts_vagrant -u vagrant -k`, or
* `ansible-playbook devbox.yml -i hosts_aws -u ec2-user --private-key=</path/to/private/key.pem>`

NOTE: for EC2 boxes, uses the public IP in the hosts file, not the domain name.
The domain names are usually too long and cause Ansible to vommit.

If you're using Vagrant and have more than one Vagrant box running, you will
need to change the port number in `hosts_vagrant` to the port being forwarded
to that particular vagrant instance

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

