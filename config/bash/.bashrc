alias nrb='sudo install -m 644 ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix && sudo nixos-rebuild switch'
alias ocs='opencode db "SELECT id, title, directory, time_updated FROM session WHERE parent_id IS NULL ORDER BY time_updated DESC"'
alias dot='cd ~/dotfiles'
