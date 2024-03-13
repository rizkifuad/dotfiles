if status is-interactive
  # Commands to run in interactive sessions can go here
  # Setting default env
  set -x LANG en_US.UTF-8
  # set -x SHELL which(fish)
  # set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
  set -x EDITOR nvim

  # Set N (Node Package Manager) PREFIX
  set -x N_PREFIX $HOME/.n

  # Set GOPATH
  set -x GOPATH $HOME/go
  # set -x GOROOT $HOME/go
  set -x GOBIN $GOPATH/bin

  set -x ANDROID_SDK_ROOT $HOME/Android/Sdk
  set -x ANDROID_HOME $HOME/Android/Sdk
  set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk

  # Setting PATH
  set PATH $HOME/.local/bin $PATH
  # set PATH /opt/homebrew/bin $PATH
  set PATH $HOME/.n/bin $PATH
  set PATH $GOBIN $PATH
  set PATH $HOME/build/flutter/bin $PATH
  set PATH $HOME/.cargo/bin $PATH
  set PATH $HOME/.pub-cache/bin $PATH
  set PATH $JAVA_HOME/bin $PATH
  set PATH $ANDROID_SDK_ROOT/emulator $PATH
  set PATH $ANDROID_SDK_ROOT/platform-tools $PATH
  # set PATH /opt/homebrew/opt/mysql-client@5.7/bin $PATH
  set PATH $HOME/.gvm/bin $PATH
  set PATH $HOME/.local/share/neovim/bin $PATH

  set PATH $HOME/.gobrew/current/bin $PATH
  set PATH $HOME/.gobrew/bin $PATH

  # FZF command
  set -x FZF_DEFAULT_COMMAND "rg --files --hidden"
  #fzf_configure_bindings --directory=\ct

  # Tmux quick attach
  abbr -a tma tmux attach -t 

  # exa for ls
  set -x EXA_ICON_SPACING 2
  abbr -a ls "exa --icons --color=always"

  # Fancy icon for tmux
  abbr -a nf "echo \"          異  \"  "

  # Telescope fzf projects
  abbr -a p telescope_projects

  # nvim for ftp
  abbr -a snvim "nvim --listen /tmp/nvimsocket"

  # tmux new
  abbr -a t "tmux_new"

  abbr -a sail "./vendor/bin/sail"

  abbr -a godb "killall dlv; dlv debug --continue --accept-multiclient --listen=:2345 --headless=true --api-version=2 --log"

  abbr -a d "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

  # ssh term
  # abbr -a ssh "TERM=screen-256color ssh"

  # Bun
  set -Ux BUN_INSTALL "/Users/rizki/.bun"
  set -px --path PATH "/Users/rizki/.bun/bin"

end

set -x N_PREFIX "$HOME/.n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

set -x N_PREFIX "$HOME/.n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

alias gsed="sed"
