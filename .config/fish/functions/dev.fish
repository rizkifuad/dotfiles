function dev -w "start development window"
  tmux split-window -v -l 20
  # tmux select-layout even-vertical
  tmux select-pane -t 0
  set -l icon
  if test -f package.json
    set icon " "
    set -l react "$(grep 'react\|solid' package.json)"
    if test -n $react
      set icon ""
    end
  end

  if test -f go.mod
    set icon ""
  end

  if test -f pubspec.yaml
    set icon ""
  end

  tmux rename-window "$icon $(basename (prompt_pwd))"
  nvim
end
