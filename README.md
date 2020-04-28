# Install in another system

```
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo ".dotfiles.git" >> .gitignore
git clone --bare https://www.github.com/rizkifuad/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

# Source
https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html
https://www.atlassian.com/git/tutorials/dotfiles
