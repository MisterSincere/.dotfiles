if status is-interactive
and not set -q TMUX
    exec tmux
end

set fish_greeting ""

zoxide init fish --cmd cd | source
