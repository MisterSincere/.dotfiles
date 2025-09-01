" Vim syntax file
" Language: mtstudio project file format

if exists("b:current_syntax")
	finish
endif

syn match Type '\a\+' display contained
syn region mt_region start='\[' end=']' transparent contains=Type
syn region Comment start='#' end='\n'
