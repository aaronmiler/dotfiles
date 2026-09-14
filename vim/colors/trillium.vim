" Trillium — cterm-only colorscheme, same convention as vim-colors-solarized:
" no termguicolors, just ANSI slot numbers. The real color for each slot
" comes from whichever Ghostty theme is active (Trillium Dark / Trillium Light,
" see ghostty_themes/), so this file never hardcodes hex and never needs to
" know it. &background is expected to already be set correctly (existing
" auto-detect handles that, same as it did for solarized).

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'trillium'

if &background ==# 'dark'
  hi Normal          ctermfg=7 ctermbg=NONE
  hi Comment         ctermfg=8
  hi Constant        ctermfg=3
  hi String          ctermfg=2
  hi Character       ctermfg=2
  hi Number          ctermfg=3
  hi Boolean         ctermfg=3
  hi Float           ctermfg=3
  hi Identifier      ctermfg=NONE
  hi Function        ctermfg=4
  hi Statement       ctermfg=5 cterm=bold
  hi Conditional     ctermfg=5 cterm=bold
  hi Repeat          ctermfg=5 cterm=bold
  hi Label           ctermfg=5 cterm=bold
  hi Keyword         ctermfg=5 cterm=bold
  hi Exception       ctermfg=5 cterm=bold
  hi Operator        ctermfg=NONE
  hi PreProc         ctermfg=6
  hi Include         ctermfg=6
  hi Define          ctermfg=6
  hi Macro           ctermfg=6
  hi PreCondit       ctermfg=6
  hi Type            ctermfg=6
  hi StorageClass    ctermfg=6
  hi Structure       ctermfg=6
  hi Typedef         ctermfg=6
  hi Special         ctermfg=4
  hi SpecialChar     ctermfg=4
  hi Tag             ctermfg=4
  hi Delimiter       ctermfg=4
  hi SpecialComment  ctermfg=4
  hi Debug           ctermfg=4
  hi Underlined      ctermfg=4 cterm=underline
  hi Error           ctermfg=1 cterm=bold
  hi Todo            ctermfg=0 ctermbg=3 cterm=bold

  hi LineNr          ctermfg=8 ctermbg=NONE
  hi CursorLineNr    ctermfg=3 ctermbg=NONE cterm=bold
  hi CursorLine      ctermbg=0 cterm=NONE
  hi Visual          ctermbg=0
  hi Search          ctermfg=0 ctermbg=3
  hi IncSearch       ctermfg=0 ctermbg=1
  hi StatusLine      ctermfg=7 ctermbg=0
  hi StatusLineNC    ctermfg=8 ctermbg=0
  hi VertSplit       ctermfg=0 ctermbg=NONE
  hi Pmenu           ctermfg=7 ctermbg=0
  hi PmenuSel        ctermfg=0 ctermbg=3
  hi NonText         ctermfg=8
  hi SpecialKey      ctermfg=8
  hi MatchParen      ctermfg=0 ctermbg=3 cterm=bold
  hi DiffAdd         ctermfg=2 ctermbg=NONE
  hi DiffDelete      ctermfg=1 ctermbg=NONE
  hi DiffChange      ctermfg=4 ctermbg=NONE
  hi DiffText        ctermfg=3 ctermbg=NONE cterm=bold

  hi rubySymbol               ctermfg=6
  hi rubyInstanceVariable     ctermfg=9
  hi rubyClassVariable        ctermfg=9
  hi rubyConstant             ctermfg=3
  hi rubyClassName            ctermfg=3
  hi rubyModuleName           ctermfg=3
  hi rubyInterpolationDelimiter ctermfg=4
else
  hi Normal          ctermfg=0 ctermbg=NONE
  hi Comment         ctermfg=8
  hi Constant        ctermfg=3
  hi String          ctermfg=2
  hi Character       ctermfg=2
  hi Number          ctermfg=3
  hi Boolean         ctermfg=3
  hi Float           ctermfg=3
  hi Identifier      ctermfg=NONE
  hi Function        ctermfg=4
  hi Statement       ctermfg=5 cterm=bold
  hi Conditional     ctermfg=5 cterm=bold
  hi Repeat          ctermfg=5 cterm=bold
  hi Label           ctermfg=5 cterm=bold
  hi Keyword         ctermfg=5 cterm=bold
  hi Exception       ctermfg=5 cterm=bold
  hi Operator        ctermfg=NONE
  hi PreProc         ctermfg=6
  hi Include         ctermfg=6
  hi Define          ctermfg=6
  hi Macro           ctermfg=6
  hi PreCondit       ctermfg=6
  hi Type            ctermfg=6
  hi StorageClass    ctermfg=6
  hi Structure       ctermfg=6
  hi Typedef         ctermfg=6
  hi Special         ctermfg=4
  hi SpecialChar     ctermfg=4
  hi Tag             ctermfg=4
  hi Delimiter       ctermfg=4
  hi SpecialComment  ctermfg=4
  hi Debug           ctermfg=4
  hi Underlined      ctermfg=4 cterm=underline
  hi Error           ctermfg=1 cterm=bold
  hi Todo            ctermfg=15 ctermbg=3 cterm=bold

  hi LineNr          ctermfg=8 ctermbg=NONE
  hi CursorLineNr    ctermfg=3 ctermbg=NONE cterm=bold
  hi CursorLine      cterm=reverse ctermbg=NONE
  hi Visual          cterm=reverse
  hi Search          ctermfg=15 ctermbg=3
  hi IncSearch       ctermfg=15 ctermbg=1
  hi StatusLine      cterm=reverse
  hi StatusLineNC    ctermfg=8 cterm=NONE
  hi VertSplit       ctermfg=8 ctermbg=NONE
  hi Pmenu           ctermfg=8 cterm=reverse
  hi PmenuSel        ctermfg=3 cterm=reverse
  hi NonText         ctermfg=8
  hi SpecialKey      ctermfg=8
  hi MatchParen      ctermfg=15 ctermbg=3 cterm=bold
  hi DiffAdd         ctermfg=2 ctermbg=NONE
  hi DiffDelete      ctermfg=1 ctermbg=NONE
  hi DiffChange      ctermfg=4 ctermbg=NONE
  hi DiffText        ctermfg=3 ctermbg=NONE cterm=bold

  hi rubySymbol               ctermfg=6
  hi rubyInstanceVariable     ctermfg=9
  hi rubyClassVariable        ctermfg=9
  hi rubyConstant             ctermfg=3
  hi rubyClassName            ctermfg=3
  hi rubyModuleName           ctermfg=3
  hi rubyInterpolationDelimiter ctermfg=4
endif
