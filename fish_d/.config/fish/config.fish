if status is-interactive
and not set -q TMUX
#exec tmux
end

set fish_greeting ""

#[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

zoxide init fish --cmd cd | source

# Created by `pipx` on 2025-08-22 09:45:38
set PATH $PATH /home/kaffeekind/.local/bin
