if [ "$(uname)" == "Darwin" ]; then
    #running on Mac OS
    echo "Running install on macos..."
    echo "Install homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "Install essentials..."
    brew install zsh git

    echo "Install oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Installing desktop apps..."
    brew install --cask rectangle
    brew install --cask whatsapp
    brew install --cask skype
    brew install --cask slack
    brew install --cask google-chrome
    brew install --cask warp

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    #running on Windows 
    echo "Stop right now and reconsider your actions"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    #running on Linux
    echo "Install essentials..."
    sudo apt install git
    sudo apt install zsh

    echo "Install oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

mkdir $HOME/.vim

DOTFILES_DIR=`echo $HOME`/.dotfiles
ln -sfv "$DOTFILES_DIR/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/.inputrc" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.ycm_extra_conf.py" ~/.vim
ln -sfv "$DOTFILES_DIR/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/.tmuxline" ~

mkdir -p ~/.vim/templates
ln -sfv "$DOTFILES_DIR/.vim/templates/c_template.txt" ~/.vim/templates
ln -sfv "$DOTFILES_DIR/.vim/templates/py_template.txt" ~/.vim/templates

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all vim plugins 
vim +PluginInstall +qall

# Tmux plugin manager install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
