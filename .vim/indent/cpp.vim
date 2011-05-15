" setlocal nolisp
" setlocal noautoindent
"
" setlocal indentexpr=GetCppIndent(v:lnum)
"
" if exists("*GetCppIndent")
"     finish
" endif
"
" function! GetCppIndent(lnum)
"     let cindent = cindent(a:lnum)
"     if a:lnum == 1 | return cindent | endif
"
"     let pattern1 = 'namespace\s\+\S\+\s*{\s*\%$'
"     " pattern2 is used to match this case:
"     " class c : public b
"     "     { &lt;-- cursor
"     let clspat = 'class\s\+\S\+\s*:\s*[^{]*'
"     let pattern2 = 'namespace\s\+\S\+\s*{\s*'.clspat.'\%$'
"
"     let lines = join(getline(max([a:lnum - 10, 1]) , a:lnum-1),' ')
"
"     if  lines =~ pattern1
"         return indent(CppFindOccurence('namespace', a:lnum))
"     elseif  lines =~ pattern2 && getline(a:lnum) =~ '^\s*{'
"         return indent(CppFindOccurence('class', a:lnum))
"     else
"         return cindent
"     endif
" endfunction
"
" function! CppFindOccurence(pattern, lnum)
"     for line in range(a:lnum-1,a:lnum-10,-1)
"         if getline(line) =~ a:pattern
"             return line
"         endif
"     endfor
"     return -1
" endfunction
"
"
"
" setlocal cindent
" setlocal cinoptions=l1,g0,t0,(0
"
"











function! IndentNamespace()
    let l:cline_num = line('.')
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    let l:retv = cindent('.')
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    if l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction

setlocal indentexpr=IndentNamespace()


setlocal cindent
setlocal smartindent
setlocal autoindent
setlocal cinoptions=l1,g0,t0,(0,W4



