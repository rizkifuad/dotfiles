if status is-interactive
    # Start X at login
  if status is-login
      if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        # startx -- -keeptty
        # $HOME/.local/bin/steamos-session-select
        # $HOME/.local/bin/session-start
        # $HOME/.local/bin/gamemode
      end

      if test "$XDG_VTNR" = 2
        # $HOME/.local/bin/game stream
      # systemd-run --user --scope tmux new-session
      end
  end

  set -U fish_greeting ""
  # Commands to run in interactive sessions can go here
  # Setting default env
  set -x LANG en_US.UTF-8
  # set -x SHELL which(fish)
  set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
  set -x EDITOR nvim

  # Set N (Node Package Manager) PREFIX
  set -x N_PREFIX $HOME/.n

  # Set GOPATH
  set -x GOPATH $HOME/go
  # set -x GOROOT $HOME/go
  set -x GOBIN $GOPATH/bin

  set -x ANDROID_SDK_ROOT $HOME/Android
  set -x ANDROID_HOME $HOME/Android/Sdk
  # set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
  # set -x JAVA_HOME /opt/homebrew/opt/openjdk
  set -x JAVA_HOME /opt/android-studio/jbr

  set -x RIPGREP_CONFIG_PATH $HOME/.ripgreprc

  set -x TODO_DIR $HOME/notes

  # Setting PATH
  set PATH $HOME/.local/bin $PATH
  # set PATH /opt/homebrew/bin $PATH
  set PATH $HOME/.n/bin $PATH
  set PATH $HOME/.npm-global/bin $PATH
  set PATH $GOBIN $PATH
  set PATH $HOME/.build/flutter/bin $PATH
  set PATH $HOME/.cargo/bin $PATH
  set PATH $HOME/.pub-cache/bin $PATH
  set PATH $JAVA_HOME/bin $PATH
  set PATH $ANDROID_HOME/emulator $PATH
  set PATH $ANDROID_HOME/platform-tools $PATH
  set PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
  # set PATH /opt/homebrew/opt/mysql-client@5.7/bin $PATH
  set PATH $HOME/.local/share/neovim/bin $PATH

  set PATH $HOME/.gobrew/current/bin $PATH
  set PATH $HOME/.gobrew/bin $PATH
  set PATH /Applications/WezTerm.app/Contents/MacOS $PATH


  # FZF command
  set -x FZF_DEFAULT_COMMAND "rg --files --hidden"
  fzf_configure_bindings --directory=\ct

  # Tmux quick attach
  abbr -a tma tmux attach -t 

  # Tmux quick start
  abbr -a tm systemd-run --user --scope tmux new-session

  abbr -a vs nvim --listen /tmp/nvim.
 

  # exa for ls
  set -x EZA_ICON_SPACING 2
  abbr -a ls "eza --icons --color=always"

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
  abbr -a ssh "TERM=screen-256color ssh"

  abbr -a k "kubectl --insecure-skip-tls-verify"

  abbr -a p "pnpm"

  abbr -a tx "tuxedo"

  alias bunx="bun x"

  # Bun
  set -Ux BUN_INSTALL "/Users/rizki/.bun"
  set -px --path PATH "/Users/rizki/.bun/bin"

end

set -x N_PREFIX "$HOME/.n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.fish 2>/dev/null || :

functions -c fish_prompt _original_fish_prompt 2>/dev/null

function fish_prompt --description 'Write out the prompt'
  if set -q ZMX_SESSION
    echo -n "[$ZMX_SESSION] "
  end
  _original_fish_prompt
end
