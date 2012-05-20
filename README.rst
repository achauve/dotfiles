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
- emacs >= 24 (ppa:cassou/emacs and http://emacs.naquadah.org)

Install
=======

In a terminal::

  git clone git://github.com/achauve/dotfiles.git
  cd dotfiles
  # clone all the vim plugins as git submodules
  git submodule init
  git submodule update

  chsh -s /bin/zsh


For ropevim to work, you need to install rope (not included here), and you need
to install ropevim.py manually::

  cd .vim/bundle/ropevim
  python setup.py install --home=~/local # for example

For vimclojure, you need to compile the nailgun client::

  cd .vim/bundle/vimclojure-nailgun-client
  make


To actually use these files as your config files, the easiest way is to symlink
them::

  cd
  ln -s dotfiles/.vim
  ln -s dotfiles/.vimrc

  # ... keep doing that for all files you are interested in


Note: to update the plugins to their last revisions published on github::

  git submodule foreach git pull origin master


Links
=====

A very nice source of inspiration: https://bitbucket.org/sjl/dotfiles
(thanks to Steve Losh)

