"=============================================================================
" File: plugin/fzf-preview.vim
" Author: yuki-ycino
" Created: 2018-01-25
"=============================================================================

scriptencoding utf-8

if exists('s:loaded')
  finish
endif
let s:loaded = 1

if !exists('g:fzf_preview_layout')
  let g:fzf_preview_layout = 'top split new'
endif

if !exists('g:fzf_preview_rate')
  let g:fzf_preview_rate = 0.3
endif

if !exists('g:fzf_full_preview_toggle_key')
  let g:fzf_full_preview_toggle_key = '<C-s>'
endif

if !exists('g:fzf_preview_command')
  if executable('ccat') == 1
    let g:fzf_preview_command = 'ccat --color=always {}'
  else
    let g:fzf_preview_command = 'head -100 {}'
  endif
endif

if !exists('g:fzf_binary_preview_command')
  let g:fzf_binary_preview_command = 'echo "{} is a binary file"'
endif

if !exists('g:fzf_preview_filelist_command')
  if executable('rg') == 1
    let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --glob "!.git/*"'
  else
    let g:fzf_preview_filelist_command = 'git ls-files --exclude-standard'
  endif
endif

if !exists('g:fzf_preview_grep_cmd')
  let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading'
endif

let s:save_cpo = &cpoptions
set cpoptions&vim

command! ProjectFilesPreview         :call fzf_preview#fzf_files()
command! BuffersPreview              :call fzf_preview#fzf_buffers()
command! OldFilesPreview             :call fzf_preview#fzf_oldfiles()
command! ProjectOldFilesPreview      :call fzf_preview#fzf_project_oldfiles()
command! -nargs=? ProjectGrepPreview :call fzf_preview#fzf_project_grep(<f-args>)

let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim:set expandtab shiftwidth=2 softtabstop=2 tabstop=2 foldenable foldmethod=marker: