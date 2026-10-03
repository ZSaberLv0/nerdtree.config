
let g:NERDTreeNodeDelimiter = "\t"
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinSize = 50
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeIgnore=[]
if !empty(get(g:, 'zf_vim_cache_path', ''))
    let g:NERDTreeBookmarksFile = g:zf_vim_cache_path . '/NERDTreeBookmarks'
endif
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
nnoremap <silent> <leader>ve :NERDTreeToggle<cr>
nnoremap <silent> <leader>ze :NERDTreeFind<cr>
augroup ZF_Plugin_nerdtree_augroup
    autocmd!
    autocmd FileType nerdtree
                \  setlocal tabstop=2
                \| nmap <buffer><silent> <leader>ze :NERDTreeToggle<cr>:NERDTreeFind<cr>
                \| nmap <buffer><silent> cd \NERDTree?cd\NERDTree?CD:pwd<cr>
                \| nmap <buffer><silent> X gg\NERDTree?X
                \| nmap <buffer><silent> u \NERDTree?u:let _l=line('.')<cr>gg\NERDTree?cd\NERDTree?CD:<c-r>=_l<cr><cr>:pwd<cr>
                \| nnoremap <buffer><silent> cf :call ZF_Plugin_nerdtree_excludeToggle()<cr>
    autocmd User ZFIgnoreOnUpdate call ZF_Plugin_nerdtree_excludeUpdate()
augroup END
function! ZF_Plugin_nerdtree_excludeUpdate()
    if exists('b:ZF_Plugin_nerdtree_excludeToggleFlag')
        let g:NERDTreeIgnore = ZF_Plugin_nerdtree_excludeList()
        NERDTreeRefreshRoot
    endif
endfunction
function! ZF_Plugin_nerdtree_excludeToggle()
    if !exists('b:ZF_Plugin_nerdtree_excludeToggleFlag')
        let b:ZF_Plugin_nerdtree_excludeToggleFlag = 1
        let g:ZF_Plugin_nerdtree_statuslineSaved = g:NERDTreeStatusline
        let g:NERDTreeIgnore = ZF_Plugin_nerdtree_excludeList()
        NERDTreeRefreshRoot
    else
        normal \NERDTree?cf
        let b:ZF_Plugin_nerdtree_excludeToggleFlag = 1 - b:ZF_Plugin_nerdtree_excludeToggleFlag
    endif
    if b:ZF_Plugin_nerdtree_excludeToggleFlag
        let g:NERDTreeStatusline = 'NOTE: filter on'
    else
        let g:NERDTreeStatusline = g:ZF_Plugin_nerdtree_statuslineSaved
    endif
    let &l:statusline = g:NERDTreeStatusline
endfunction
function! ZF_Plugin_nerdtree_excludeList()
    if !exists('*ZFIgnoreGet')
        return []
    endif
    return ZFIgnoreToRegexp(ZFIgnoreGet({
                \   'bin' : 0,
                \   'media' : 0,
                \ }))
endfunction
let g:NERDTreeMapActivateNode = 'o'
let g:NERDTreeMapChangeRoot = '\NERDTree?CD'
let g:NERDTreeMapChdir = '\NERDTree?cd'
let g:NERDTreeMapCloseChildren = '\NERDTree?X'
let g:NERDTreeMapCloseDir = 'x'
let g:NERDTreeMapDeleteBookmark = ''
let g:NERDTreeMapMenu = 'm'
let g:NERDTreeMapHelp = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpParent = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMapJumpRoot = ''
let g:NERDTreeMapOpenExpl = ''
let g:NERDTreeMapOpenInTab = ''
let g:NERDTreeMapOpenInTabSilent = ''
let g:NERDTreeMapOpenRecursively = 'O'
let g:NERDTreeMapOpenSplit = ''
let g:NERDTreeMapOpenVSplit = ''
let g:NERDTreeMapPreview = ''
let g:NERDTreeMapPreviewSplit = ''
let g:NERDTreeMapPreviewVSplit = ''
let g:NERDTreeMapQuit = 'q'
let g:NERDTreeMapRefresh = ''
let g:NERDTreeMapRefreshRoot = 'r'
let g:NERDTreeMapToggleBookmarks = ''
let g:NERDTreeMapToggleFiles = ''
let g:NERDTreeMapToggleFilters = '\NERDTree?cf'
let g:NERDTreeMapToggleHidden = 'ch'
let g:NERDTreeMapToggleZoom = ''
let g:NERDTreeMapUpdir = '\NERDTree?u'
let g:NERDTreeMapUpdirKeepOpen = ''
let g:NERDTreeMapCWD = 'CD'

