function! fzf_preview#remote#resource#buffers#get() abort
  let list = filter(range(1, bufnr('$')),
  \ { _, bufnr -> bufexists(bufnr) && buflisted(bufnr) && filereadable(expand('#' . bufnr . ':p')) && bufnr != bufnr('%')}
  \ )

  return map(list, { _, bufnr -> (getbufvar(bufnr, '&modified') ? '+ ' : '') . bufname(bufnr) })
endfunction