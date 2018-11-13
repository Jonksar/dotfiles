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
