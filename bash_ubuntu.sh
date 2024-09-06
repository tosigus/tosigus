#!/bin/bash 
# Torsten Osigus: Stand 20240906

echo "ACHTUNG: Überwiegend nur für das Betriebssystem Ubuntu!"
echo hostname && hostname -I

read -p "Installieren von git zsh tmux htop glances curl? (j/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Jj]$ ]]
then
    echo "Notwendige Pakete installieren"
    sudo apt update && sudo apt dist-upgrade
    sudo apt -y install tmux git git-lfs vim curl htop glances fzf python3-pip bat
fi

read -p "Bash/Input/Tmux anpassen? (j/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Jj]$ ]]
then
    mkdir .backup_shell
    mv ~/.inputrc ~/.backup_shell/.inputrc_`date +"%Y-%m-%d_%T"`
    mv ~/.bashrc ~/.backup_shell/.bashrc_`date +"%Y-%m-%d_%T"`
    mv ~/.tmux.conf ~/.backup_shell/.tmux.conf_`date +"%Y-%m-%d_%T"`
    mv ~/.vimrc ~/.backup_shell/.vimrc_`date +"%Y-%m-%d_%T"`
	echo "Inputrc anpassen"
    wget https://github.com/tosigus/tosigus/-/raw/master/dateien/inputrc
    less inputrc > ~/.inputrc
    rm inputrc
	echo "Inputrc anpassen fertig"
    wget https://github.com/tosigus/tosigus/-/raw/master/dateien/bashrc
    less bashrc > ~/.bashrc
    rm bashrc
    echo "Bash wurde eingerichtet"
    wget https://github.com/tosigus/tosigus/-/raw/master/dateien/tmux.conf
    less tmux.conf > ~/.tmux.conf
    rm tmux.conf
    echo "tmux wurde installiert und eingerichtet"
    echo "Vim einrichten"
    mkdir ~/.vim && mkdir ~/.vim/backup &&  mkdir ~/.vim/swap &&  mkdir ~/.vim/undo 
    #git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ; ~/.fzf/install
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    wget https://github.com/tosigus/tosigus/-/raw/master/dateien/vimrc
    less vimrc > ~/.vimrc
    rm vimrc
    vim +PlugInstall +qall
    echo "Vim wurde installiert und konfiguriert"
    echo 'include /usr/share/nano/sh.nanorc' > ~/.nanorc
    echo "Nano mit Syntax Highlightning versehen"
fi

echo "Installation/Anpassung beendet"
