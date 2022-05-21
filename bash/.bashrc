# color the prompt
force_color_prompt=yes

# default variant from arch linux i guess
DEFAULT='[\u@\h \W]\$ '

# u@h:W $
PROMPT1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W \[\033[00m\]\$ '

# u:W $
PROMPT2='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W \[\033[00m\]\$ '

# u:w $
PROMPT3='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w \[\033[00m\]\$ '

# u@h W$
PROMPT4='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W\[\033[0m\]\$ '

PS1=$PROMPT4

# aliases
alias ls="ls --color"
alias la="ls -a"
alias ll="ls -al"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias cg="bash ~/.config/scripts/cg_helper_script.sh"
alias mtpull="bash ~/.config/scripts/mtstudio_pull.sh"

if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
  exec fish
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kaffeekind/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kaffeekind/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kaffeekind/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kaffeekind/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

