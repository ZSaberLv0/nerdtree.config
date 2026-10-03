
" FUNCTION: s:chRoot(node) {{{1
" changes the current root to the selected one
function! s:chRoot(node) abort
    call b:NERDTree.changeRoot(a:node)
endfunction

" FUNCTION: s:findAndRevealPath(pathStr) {{{1
function! s:findAndRevealPath(pathStr) abort
    let l:pathStr = !empty(a:pathStr) ? a:pathStr : expand('%:p')
    let l:revealOpts = {}

    if empty(l:pathStr)
        call nerdtree#echoWarning('no file for the current buffer')
        return
    endif

    if !filereadable(l:pathStr)
        let l:pathStr = fnamemodify(l:pathStr, ':h')
        let l:revealOpts['open'] = 1
    endif

    try
        let l:pathObj = g:NERDTreePath.New(l:pathStr)
    catch /^NERDTree.InvalidArgumentsError/
        call nerdtree#echoWarning('invalid path')
        return
    endtry

    if !g:NERDTree.ExistsForTab()
        try
            let l:cwd = g:NERDTreePath.New(getcwd())
        catch /^NERDTree.InvalidArgumentsError/
            call nerdtree#echo('current directory does not exist.')
            let l:cwd = l:pathObj.getParent()
        endtry

        if l:pathObj.isUnder(l:cwd)
            call g:NERDTreeCreator.CreateTabTree(l:cwd.str())
        else
            call g:NERDTreeCreator.CreateTabTree(l:pathObj.getParent().str())
        endif
    else
        NERDTreeFocus

        if !l:pathObj.isUnder(b:NERDTree.root.path)
            call s:chRoot(g:NERDTreeDirNode.New(l:pathObj.getParent(), b:NERDTree))
        endif
    endif

    if l:pathObj.isHiddenUnder(b:NERDTree.root.path)
        call b:NERDTree.ui.setShowHidden(1)
    endif

    let l:node = b:NERDTree.root.reveal(l:pathObj, l:revealOpts)
    call b:NERDTree.render()
    call l:node.putCursorHere(1, 0)
endfunction

function! NERDTreeFind_fix()
    command! -n=? -complete=file -bar NERDTreeFind call s:findAndRevealPath('<args>')
endfunction
augroup NERDTreeFind_fix_augroup
    autocmd!
    autocmd VimEnter * call NERDTreeFind_fix()
    call NERDTreeFind_fix()
augroup END

