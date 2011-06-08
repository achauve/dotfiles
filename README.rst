================
Dotfiles
================

This is a bunch of config files for linux. The biggest part is for vim.

There are config files for:

- vim
- bash
- git
- mercurial
- emacs
- awesome
- wmfs


Prerequesites
=============

For vim you need:

- vim >= 7.3
- ctags
- these two directories: ~/tmp/vim/swap and ~/tmp/vim/backup (you can also
  disable backup and swap files in .vimrc)


Install
=======

In a terminal::

  git clone git://github.com/achauve/dotfiles.git
  cd dotfiles
  # clone all the vim plugins as git submodules
  git submodule init
  git submodule update


To actually use these files as your config files, the easiest way is to symlink
them::

  cd
  ln -s dotfiles/.vim
  ln -s dotfiles/.vimrc

  # ... keep doing that for all files you are interested in

