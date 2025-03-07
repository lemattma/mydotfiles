Very simple configuration files based on https://github.com/paulirish/dotfiles

## First run

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lemattma/mydotfiles/HEAD/first-run.sh)"
```

## Install Oh My Zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Install dotfiles

```
chmod +x install.sh
./install.sh

# or symlink files as needed.
ln -s .tmux.conf ~/.tmux.conf
ln -s .vimrc ~/.vimrc
```

## Setup Vim and Vundle

https://github.com/VundleVim/Vundle.vim

```
# Vundle install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins inside Vim
:PluginInstall
# Or, from command line
vim +PluginInstall +qall
```

## Powerline

https://powerline.readthedocs.io/en/latest/installation/osx.html
https://github.com/powerline/fonts

Powerline alternative

https://github.com/vim-airline/vim-airline

## Iterm2

To import settings go to `Preferences > General > Load preferences from a custom folder or URL`. You'll need to refresh the cache afterwards.

```
defaults read com.googlecode.iterm2
# or..
killall cfprefsd
```

## Sublime

Add `subl` to `bin`

```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
ln -s ~/Dropbox/Sublime/Packages/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
```

Link user config to Dropbox

```
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -s ~/Dropbox/Sublime/Packages/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
```

## Misc

```
npm install -g git-recent

npm install -g diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

npm install -g git-open
```
