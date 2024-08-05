#!/bin/sh
vim_installation() {
  cp .vimrc ~/.vimrc
  yaourt -S vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  clear
  apt-get install silversearcher-ag
  clear
  vim -c "PlugInstall" -c "q" -c "q"
}

node_installation() {
  # installs nvm (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  # download and install Node.js (you may need to restart the terminal)
  nvm install 20

  # verifies the right Node.js version is in the environment
  node -v # should print `v20.16.0`

  # verifies the right npm version is in the environment
  npm -v # should print `10.8.1`
}

runBashScripts() {
  clear
  echo "\nMoving scripts to your user directory..."
  cp .bashrc ~/.bashrc
  cp .bash_profile ~/.bash_profile
  cp .bash_aliases ~/.bash_aliases
  clear
  echo "Installing or updating GIT"
  yaourt -Syu git
  clear
  echo "\nWhat is your name to be displayed at your GIT user.name?\n\nFor Example, mine is \"Matheus Marsiglio\"\n"
  read git_config_user_name
  git config --global user.name "$git_config_user_name"
  clear
  echo "\nWhat is your common used GIT email?\n\n(Probably a personal one)\n"
  read git_config_user_email
  git config --global user.email $git_config_user_email
  clear
  echo "\nWant to set created branches origin with same as local? (y/n)"
  read setup_branch_origin_with_local
  if echo "$setup_branch_origin_with_local" | grep -iq "^y" ;then
    git config --global push.default current
  else
    clear
  fi
  echo "\nI'm about to set as your default GIT editor as VIM and I highly recommend it.\n\n"
  echo "Can I do that for you? (y/n)\n\n"
  read git_core_editor_to_vim
  if echo "$git_core_editor_to_vim" | grep -iq "^y" ;then
    git config --global core.editor vim
  else
    echo "\nOk, it's on your hands. :) Let's move on"
  fi
  gitAliases
  echo "\n\n\nDone of git globals, let's install some helpers"
  echo "\n\n\nStarting checking if you have wget"
  yaourt -S wget
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
  mv git-completion.bash ~/.git-completion.bash
  mv git-prompt.sh ~/.git-prompt.sh
  clear
  echo "\nIf you type wrongly some command, just type run \"fuck\" for autocorrect\n\n\n"
  yaourt -S thefuck
  clear
  echo "\nDone with bash and GIT installations.\n\n"
  echo "I have a nice VIM config to install here for you.\n\n"
  echo "Wanna install it? (y/n)"
  read wanna_install_vim
  if echo "$wanna_install_vim" | grep -iq "^y" ;then
    vim_installation
  else
    clear
    echo "Ok then ¯\_(ツ)_/¯"
  fi
  clear
  echo "Wanna install Node? (y/n)"
  read wanna_install_node
  if echo "$wanna_install_node" | grep -iq "^y" ;then
    vim_installation
  else
    clear
    echo "Ok then ¯\_(ツ)_/¯"
  fi
  echo "\n\n\n\n\n"
  echo "Everything's done! \n\n Make sure to mark \"Run command as a login shell\" option in your Terminal preferences to bash be interpreted."
echo "\n\nDon't forget to restart your terminal after the installations"
}

gitAliases() {
  echo "Whant to setup git aliases? (y/n)"
  read wanna_set_git_aliases
  if echo "$wanna_set_git_aliases" | grep -iq "^y" ;then
    setGitAliases
  else
    clear
    echo "Alrighty then =}"
  fi
}

setGitAliases() {
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.unstage "reset HEAD --"
  git config --global alias.visual "!gitk"
  git config --global alias.bd "branch -D"
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  echo "Git aliases set sucessful"
}

greetings() {
  clear
  echo "\nHi $USER.\nDo you wanna proceed with the installation? (y/n)"
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    runBashScripts
  else
    echo "Ok, anything I'm here and you can also send me a message on Twitter: @matmarsiglio :) \nCheers, \n\nM.\n\n"
  fi
}

greetings

echo "Give me any feedback about these scripts at https://github.com/matmarsiglio/dotfiles :)"

