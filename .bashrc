# Check for an interactive session
[ -z "$PS1" ] && return

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# prompt
if [ -f ~/battery.sh ]; then
    batt_prompt=' [$(~/battery.sh)]'
else
    batt_prompt=''
fi
if [ -f /usr/bin/netcfg ]; then
    netcfg_prompt=' [$(netcfg current)]'
else
    netcfg_prompt=''
fi
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] [$(date +"%d/%m %H:%M")]'${batt_prompt}${netcfg_prompt}' \$ '

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
#alias l='ls -CF'

# debian/ubuntu apt-get aliases
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias aga='sudo apt-get autoremove'
alias agd='sudo apt-get dist-upgrade'
alias asearch='apt-cache search'
alias ashow='apt-cache show'

alias cmake-release='cmake -DCMAKE_BUILD_TYPE:STRING=Release'
alias ccmake-release='ccmake -DCMAKE_BUILD_TYPE:STRING=Release'
alias cmake-debug='cmake -DCMAKE_BUILD_TYPE:STRING=Debug'
alias ccmake-debug='ccmake -DCMAKE_BUILD_TYPE:STRING=Debug'
alias cmake-clang-debug='CC=clang CXX=clang++ cmake -DCMAKE_CXX_FLAGS:STRING="-g"'
alias cmake-clang-relase='CC=clang CXX=clang++ cmake -DCMAKE_CXX_FLAGS:STRING="" -DCMAKE_BUILD_TYPE:STRING=Release'

alias hggit='hg book -d hg && hg up && hg book hg && hg push -r hg git'

alias pygrep='egrep -R -n --include='\''*.py'\'
alias pyinstall='python setup.py install --home=~/local'

alias iccsetup='source /opt/intel/bin/compilervars.sh intel64'

alias suspend='sudo pm-suspend'




export GREP_OPTIONS='--color=auto -I -n --exclude-dir=".svn" --exclude-dir=".hg"'

PATH=~/local/bin:~/local/src/dmd2/linux/bin64:${PATH}

export PYTHONPATH=~/local/lib/python

export BROWSER=firefox
export EDITOR=vim
alias mq='hg -R `hg root`/.hg/patches'


function termfb {
    export TERM=fbterm
}

function termx {
    export TERM=xterm-256color
}



# make capslock an aditional control key
#setxkbmap -option ctrl:nocaps


bind '"\C-o":"ranger\C-m"'
bind '"\C-g":"tig status\C-m"'



export PACMAN=pacman-color


if [ -f /usr/bin/keychain ]; then
    eval `keychain --eval --agents ssh id_rsa`
fi


if [ -f ~/.local_bashrc ]; then
    source ~/.local_bashrc
fi

