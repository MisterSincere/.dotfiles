function fish_prompt_get_left_prompt --description 'Get first line left prompt content'
  set -l c_normal (set_color normal)
  set -l c_green (set_color --bold green)
  set -l c_blue (set_color blue)

  # If we are in a virtualenv, we display its name
  #if set -q VIRTUAL_ENV; and set -q PYENV_VERSION
  #    printf '(%s)' $PYENV_VERSION
  #end

  set_color --bold '#df20df'
  printf '╒══'
  set_color --bold green
  printf '%s@%s' (whoami) (uname -n)

  set_color blue
  printf ' %s ' (prompt_pwd | awk -F "/" '{print $(NF)}')


  set_color normal

end
