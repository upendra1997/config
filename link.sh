ln -nsTfr .vimrc ~/.vimrc
mkdir -p ~/.vim
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/lua
ln -nsTfr .config/nvim/lua/custom ~/.config/nvim/lua/custom
ln -nsTfr init.vim ~/.config/nvim/init.vim
ln -nsTfr coc-settings.json ~/.vim/coc-settings.json
cat .tmux.conf >> ~/.tmux.conf.local
