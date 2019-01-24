#!/bin/bash

ALIASES="$(find ~/ -name .bash_aliases)"

if [ -z "$ALIASES" ]; then
        echo "Downloading bash aliases extra"
        curl -O https://raw.githubusercontent.com/netmanito/repo/master/bash-aliases-extra
        echo "no .bash_aliases found, creating for you"
        echo "..."
        cp ./bash-aliases-extra ~/.bash_aliases
        echo "adding bash_aliases to .bashrc"
        echo "updating shell"
        source .bashrc
        rm bash-aliases-extra
        echo "All Done!!"
else
        echo "Downloading bash aliases extra"
        curl -O https://raw.githubusercontent.com/netmanito/repo/master/bash-aliases-extra
        echo ".bash_aliases found on your home directory"
        echo "adding data to it ..."
        echo "## bash aliases extra " >> ~/.bash_aliases
        cat bash-aliases-extra >> .bash_aliases
        echo "updating shell"
        source .bashrc
        rm bash-aliases-extra
        echo "All Done!!"

fi