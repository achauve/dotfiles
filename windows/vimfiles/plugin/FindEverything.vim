" File: FindEverything.vim
" Author: szwchao (szwchao@gmail.com)
" Description: Everything is a great search engine in windows.
"              It can locates files and folders by filename instantly.
"              This script provide a interface with everything command-line
"              tools(es.exe).
" Usage: 1. Download Everything gui and command-line(es.exe) tools
"           from the website: http://www.voidtools.com
"        2. Start everything.exe and keep it running on background.
"        3. Define g:fe_es_exe in your vimrc file.
"             e.g. let g:fe_es_exe = 'd:\Everything\es.exe'
"        4. Open vim and run command ":FE"
" Version: 1.0
" Last Modified: March 13, 2011

" Prevent reloading{{{
if exists('g:find_everything')
   finish
endif
let g:find_everything = 1
"}}}

" Only working in windows {{{
if (!has("win32") && !has("win95") && !has("win64") && !has("win16"))
   finish
endif
"}}}

" Global Variables {{{
" Define which file type should be opened with vim when press enter.
if !exists('g:fe_openfile_filter')
   let g:fe_openfile_filter = ['txt', 'vim']
endif
" Define es.exe option.
if !exists('g:fe_es_option')
   let g:fe_es_option = '-s -p'
endif
" Define only show these file types when everything return results.
if !exists('g:filter_result_ext')
   let g:filter_result_ext = {'vim':1, 'txt':1, 'c':1, 'h':1, 'py':1}
endif
"}}}

" FindEverything {{{
fun! s:Handle_String(string)
   let l:str = a:string
   "trim
   let l:str = substitute(l:str, '^[[:blank:]]*\|[[:blank:]]*$', '', 'g')
   "if there is any space in file name, enclosed by double quotation
   if len(matchstr(l:str, " "))
      "don't add backslash before any white-space
      let l:str = substitute(l:str, '\\[[:blank:]]\+', " ", "g")
      let l:str = '"'.l:str.'"'
   endif
   return l:str
endfun

fun! FindEverything()
   if !exists('g:fe_es_exe')
      echo "Define g:fe_es_exe firstly!"
      return
   endif
   if !executable(g:fe_es_exe)
      echo g:fe_es_exe . " is not a executable program!"
      return
   endif
   let cmd = s:Handle_String(g:fe_es_exe)

   let pattern = input("Find: ")
   if !len(pattern)
      return
   endif
   let pattern = s:Handle_String(pattern)

   let dir = input("Find in dir: ", "", "dir")
   let dir = s:Handle_String(dir)

   let cmd = cmd .' '. g:fe_es_option . ' ' . dir . ' ' . pattern

   let l:result=system(cmd)

   if empty(l:result)
      echoh Error | echo "No files found!" | echoh None
      return
   endif
   if matchstr(l:result, 'Everything IPC window not found, IPC unavailable.') != ""
      echoh Error | echo "Everything.exe is not running!" | echoh None
      return
   endif

   " Filter the results. But it will be very slow if there are huge number of results.
   "let l:result = s:Filter_Everything_Result(l:result)

   " Show results
   call s:Show_Everything_Result(l:result)
endfun
"}}}

" Filter_Everything_Result {{{
fun! s:Filter_Everything_Result(result)
   let filter_ext = g:filter_result_ext
   let l:filter_result = ""
   for filename in split(a:result, '\n')
      let file_ext = fnamemodify(filename, ":e")
      if has_key(filter_ext, file_ext)
         let l:filter_result = l:filter_result . filename . "\n"
      endif
   endfor
   return l:filter_result
endfun
"}}}

" ToggleFEResultWindow {{{
fun! ToggleFEResultWindow()
   let bname = '_Everything_Search_Result_'
   let winnum = bufwinnr(bname)
   if winnum != -1
      if winnr() != winnum
         " If not already in the window, jump to it
         exe winnum . 'wincmd w'
         return
      else
         silent! close
         return
      endif
   endif

   let bufnum = bufnr(bname)
   if bufnum == -1
      echoh Error | echo "No FE results yet!" | echoh None
      let wcmd = bname
   else
      let wcmd = '+buffer' . bufnum
      exe 'silent! botright ' . '15' . 'split ' . wcmd
   endif
endfun
"}}}

"Show_Everything_Result {{{
fun! s:Show_Everything_Result(result)
   let bname = '_Everything_Search_Result_'
   " If the window is already open, jump to it
   let winnum = bufwinnr(bname)
   if winnum != -1
      if winnr() != winnum
         " If not already in the window, jump to it
         exe winnum . 'wincmd w'
      endif
      setlocal modifiable
      " Delete the contents of the buffer to the black-hole register
      silent! %delete _
   else
      let bufnum = bufnr(bname)
      if bufnum == -1
         let wcmd = bname
      else
         let wcmd = '+buffer' . bufnum
      endif
      exe 'silent! botright ' . '15' . 'split ' . wcmd
   endif
   " Mark the buffer as scratch
   setlocal buftype=nofile
   "setlocal bufhidden=delete
   setlocal noswapfile
   setlocal nowrap
   setlocal nobuflisted
   setlocal winfixheight
   setlocal modifiable

   " Setup the cpoptions properly for the maps to work
   let old_cpoptions = &cpoptions
   set cpoptions&vim
   " Create a mapping
   call s:Map_Keys()
   " Restore the previous cpoptions settings
   let &cpoptions = old_cpoptions
   " Display the result
   silent! %delete _
   silent! 0put =a:result

   " Delete the last blank line
   silent! $delete _
   " Move the cursor to the beginning of the file
   normal! gg
   setlocal nomodifiable
endfun
"}}}

"Map_Keys {{{
fun! s:Map_Keys()
   nnoremap <buffer> <silent> <CR>
            \ :call <SID>Open_Everything_File('filter')<CR>
   nnoremap <buffer> <silent> <2-LeftMouse>
            \ :call <SID>Open_Everything_File('external')<CR>
   nnoremap <buffer> <silent> <C-CR>
            \ :call <SID>Open_Everything_File('internal')<CR>
   nnoremap <buffer> <silent> <ESC> :close<CR>
endfun
"}}}

"Open_External {{{
fun! s:Open_External(fname)
   let cmd = substitute(a:fname,'/',"\\",'g')
   let cmd = " start \"\" \"" . cmd . "\""
   call system(cmd)
endfun
"}}}

"Open_Internal {{{
fun! s:Open_Internal(fname)
   let s:esc_fname_chars = ' *?[{`$%#"|!<>();&' . "'\t\n"
   let esc_fname = escape(a:fname, s:esc_fname_chars)
   let winnum = bufwinnr('^' . a:fname . '$')
   if winnum != -1
      " Automatically close the window
      silent! close
      " If the selected file is already open in one of the windows, jump to it
      let winnum = bufwinnr('^' . a:fname . '$')
      if winnum != winnr()
         exe winnum . 'wincmd w'
      endif
   else
      " Automatically close the window
      silent! close
      " Edit the file
      exe 'edit ' . esc_fname
   endif
endfun
"}}}

" Open_Filter {{{
fun! s:Open_Filter(fname)
   let l:filter = g:fe_openfile_filter
   let current_ext = fnamemodify(a:fname, ":e")
   for ext in l:filter
      if ext == current_ext
         call s:Open_Internal(a:fname)
         return
      endif
   endfor
   call s:Open_External(a:fname)
endfun
"}}}

" Open_Everything_File {{{
fun! s:Open_Everything_File(mode)
   let fname = getline('.')
   if fname == ''
      return
   endif

   if a:mode == 'external'
      call s:Open_External(fname)
   elseif a:mode == 'internal'
      call s:Open_Internal(fname)
   elseif a:mode == 'filter'
      call s:Open_Filter(fname)
   endif
endfun
"}}}

command! -nargs=* FE call FindEverything()
command! -nargs=* FER call ToggleFEResultWindow()

" vim:fdm=marker:fmr={{{,}}}
