function fish_prompt --description 'Write out the prompt'
    set -l c_normal (set_color normal)
    set -l c_green (set_color --bold green)
    set -l c_blue (set_color blue)

    set -l pwd (prompt_pwd | awk -F "/" '{print $(NF)}')
    set -l login (whoami)'@'(uname -n)' '
    set -l suffix '> '
    
    echo -n -s $c_green $login $c_blue $pwd $c_normal $suffix
end
