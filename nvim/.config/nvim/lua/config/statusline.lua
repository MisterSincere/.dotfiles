-- config/statusline.lua

vim.o.statusline = table.concat({
    "%{FugitiveStatusline()}",
    " %f%m",
    "%=",
    "%{gutentags#statusline()}",
    " %l/%L",
    " %y",
    " %{ObsessionStatus()}",
})
