if status is-interactive
and not set -q TMUX
#exec tmux
end

set fish_greeting ""

#[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

zoxide init fish --cmd cd | source

set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
