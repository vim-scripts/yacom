" (Y)et (A)nother (COM)ment is a plugin to easily toggle comments in line(s)
"
" Last Change: Sep 29, 2012
" Maintainer:  Gokcehan Kara <gokcehankara@gmail.com>
" License:     This file is placed in the public domain.
"
" Settings
" ~~~~~~~~
" o   comment key is set to '<leader>c' but you can override using:
"
"         let g:yacom_comment_toggle='<C-c>'
"
" o   default comment string (fallback mode) is set to begin with '#' and end
"     with '' for unknown file types
"
" TODO: nothing, it's perfect.

if exists("g:yacom_loaded")
  finish
endif
let g:yacom_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

if !hasmapto("<Plug>yacom_comment_toggle")
  map <unique> <leader>c <plug>yacom_comment_toggle
endif
noremap <unique> <silent> <script> <plug>yacom_comment_toggle <sid>yacom_comment_toggle
noremap <sid>yacom_comment_toggle :call <sid>CommentToggle()<cr>


let s:comment_begin = {
      \"c"          : "/*",
      \"cpp"        : "//",
      \"css"        : "/*",
      \"default"    : "#",
      \"go"         : "//",
      \"html"       : "<!--",
      \"java"       : "//",
      \"javascript" : "//",
      \"make"       : "#",
      \"perl"       : "#",
      \"plaintex"   : "%",
      \"python"     : "#",
      \"ruby"       : "#",
      \"sh"         : "#",
      \"tex"        : "%",
      \"vim"        : "\"",
      \"xhtml"      : "<!--",
      \"xml"        : "<!--",
      \}

" (optional)
let s:comment_end = {
      \"c"          : "*/",
      \"css"        : "*/",
      \"default"    : "",
      \"html"       : "-->",
      \"xhtml"      : "-->",
      \"xml"        : "-->",
      \}


function! s:CommentToggle()

  if has_key(s:comment_begin, &ft)
    let com_beg = s:comment_begin[&ft]
  else
    let com_beg = s:comment_begin["default"]
  endif

  if has_key(s:comment_end, &ft)
    let com_end = s:comment_end[&ft]
  else
    let com_end = s:comment_end["default"]
  endif

  let line = getline(".")

  if line[0:len(com_beg)-1] != com_beg
    let line = com_beg . line . com_end
  else
    let line = line[len(com_beg):len(line)-len(com_end)-1]
  endif

  call setline(".", line)

endfunction


let &cpo = s:save_cpo
" vim:ts=8:sw=2:et
