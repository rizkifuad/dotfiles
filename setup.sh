# Installing git
sudo pacman -Syyu
sudo pacman -S git
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install zsh
yay -S zsh
# Install dotfiles
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo ".dotfiles.git" >> .gitignore
git clone --bare https://www.github.com/rizkifuad/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
