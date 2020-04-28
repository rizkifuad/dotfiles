# Install git
sudo pacman -Syyu
sudo pacman -S git
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install zsh
yay -S zsh
# Install neovim
yay -S neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install dotfiles
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
touch ~/.config/zsh/private.zsh
source ~/.zshrc
echo ".dotfiles" >> .gitignore
git clone --bare https://www.github.com/rizkifuad/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
