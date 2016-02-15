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
