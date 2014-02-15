" Vim global plugin for awesome hacktastic hacking
" Last Change: Aug 28 2013
" Maintainer: James Kolb
"
" Copyright (C) 2013, James Kolb. All rights reserved.
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU Affero General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU Affero General Public License for more details.
" 
" You should have received a copy of the GNU Affero General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"

let g:S_save_cpo = &cpo
set cpo&vim
if exists("g:loaded_hackhack")
  finish
endif
let g:loaded_hackhack = 1

let g:S_allBuffers = {}

if !exists("g:HackHack_SetUpdateTime")
  let g:HackHack_SetUpdateTime = 1
endif

"CommandName, WindowName (default is hackhack)
function! HackHack(commandName, ...)
  highlight SignColumn ctermbg=black
  let g:ConqueTerm_TERM = 'xterm'
  let g:ConquePlusPlus_ColorOffset = '\%uA6\?'
  let g:ConquePlusPlus_SetUpdateTime = 0
  if g:HackHack_SetUpdateTime
    set updatetime=200
  endif
  exec "ConqueTerm ".a:commandName

  let g:S_HackDisplayBuffer = bufnr(expand('%'))
  let g:S_WindowSwitched = 0
  let g:S_CurrentBuffer = g:S_HackDisplayBuffer

  let g:S_allBuffers[g:S_HackDisplayBuffer] = {}
  let g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch=0
  let g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar='>'
  let g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar=g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar
  let g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex=-1
  let g:S_allBuffers[g:S_HackDisplayBuffer].BufferMarker="."
  let g:S_allBuffers[g:S_HackDisplayBuffer].windowName=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].mode="normal"
  let g:S_allBuffers[g:S_HackDisplayBuffer].PotentialPromptChar='$'
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=0
  let g:S_allBuffers[g:S_HackDisplayBuffer].AmperTest=""

  let g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab = ""

  let g:S_allBuffers[g:S_HackDisplayBuffer].History = []
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=0
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine=[]
  let g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint=0

  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchMode=' '
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistory = []
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex = []
  let g:S_allBuffers[g:S_HackDisplayBuffer].fullBuffer=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode='readline'

  let g:S_Amperstyle = 0

  if a:0>0
    let g:S_allBuffers[g:S_HackDisplayBuffer].windowName=a:1
  else
    let g:S_allBuffers[g:S_HackDisplayBuffer].windowName="HackHack"
  endif

  hi HHBorder ctermfg=DarkBlue cterm=bold guifg=darkgrey
  hi HHPrompt ctermfg=DarkCyan  guifg=darkgrey
  sign define doublearrow text=>> texthl=HHPrompt
  sign define searcharrow text=>> texthl=HHBorder
  sign define dot text=. texthl=HHPrompt
  sign define a text=a texthl=HHPrompt
  sign define b text=b texthl=HHPrompt
  sign define c text=c texthl=HHPrompt
  sign define d text=d texthl=HHPrompt
  sign define e text=e texthl=HHPrompt
  sign define f text=f texthl=HHPrompt
  sign define g text=g texthl=HHPrompt
  sign define h text=h texthl=HHPrompt
  sign define i text=i texthl=HHPrompt
  sign define j text=j texthl=HHPrompt
  sign define k text=k texthl=HHPrompt
  sign define l text=l texthl=HHPrompt
  sign define m text=m texthl=HHPrompt
  sign define n text=n texthl=HHPrompt
  sign define o text=o texthl=HHPrompt
  sign define p text=p texthl=HHPrompt
  sign define q text=q texthl=HHPrompt
  sign define r text=r texthl=HHPrompt
  sign define s text=s texthl=HHPrompt
  sign define t text=t texthl=HHPrompt
  sign define u text=u texthl=HHPrompt
  sign define v text=v texthl=HHPrompt
  sign define w text=w texthl=HHPrompt
  sign define y text=y texthl=HHPrompt
  sign define z text=z texthl=HHPrompt
  sign define A text=A texthl=HHPrompt
  sign define B text=B texthl=HHPrompt
  sign define C text=C texthl=HHPrompt
  sign define D text=D texthl=HHPrompt
  sign define E text=E texthl=HHPrompt
  sign define F text=F texthl=HHPrompt
  sign define G text=G texthl=HHPrompt
  sign define H text=H texthl=HHPrompt
  sign define I text=I texthl=HHPrompt
  sign define J text=J texthl=HHPrompt
  sign define K text=K texthl=HHPrompt
  sign define L text=L texthl=HHPrompt
  sign define M text=M texthl=HHPrompt
  sign define N text=N texthl=HHPrompt
  sign define O text=O texthl=HHPrompt
  sign define P text=P texthl=HHPrompt
  sign define Q text=Q texthl=HHPrompt
  sign define R text=R texthl=HHPrompt
  sign define S text=S texthl=HHPrompt
  sign define T text=T texthl=HHPrompt
  sign define U text=U texthl=HHPrompt
  sign define V text=V texthl=HHPrompt
  sign define W text=W texthl=HHPrompt
  sign define Y text=Y texthl=HHPrompt
  sign define Z text=Z texthl=HHPrompt
  "This will gIve an Error but still work
  silent! sign define blank text=  texthl=HHPrompt
  call g:S_DashStatusLine()
  call g:S_SetBrowseMappings()

  "set foldtext=substitute(substitute(getline(v:foldstart),'$','\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ','g'),'^.*[^\s]','¦\ \ ('.(v:foldend-v:foldstart+1).'\ lines)\ \ ','g')
  set foldtext='¦\ \ ('.(v:foldend-v:foldstart+1).'\ lines)\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ '
  set foldminlines=0
  hi Folded ctermfg=DarkBlue cterm=bold ctermbg=black guifg=darkgrey
  call matchadd('HHBorder', '^¦')
  "TODO: This is bad for multihack
  augroup HackHack
    autocmd! CursorHold 
    autocmd! CursorHoldI 
    autocmd! VimResized 
    autocmd! InsertEnter 
    autocmd! CursorMoved 
    autocmd! CursorMovedI 
  augroup END
  augroup HackHack
    autocmd  CursorHold <buffer> call g:S_UpdateTerminal(0, 0)
    autocmd  CursorHoldI <buffer> call g:S_UpdateTerminal(1, 0)
  augroup END
  if bufexists(g:S_allBuffers[g:S_HackDisplayBuffer].windowName)
    let counter = 0
    while bufexists(g:S_allBuffers[g:S_HackDisplayBuffer].windowName.counter)
      let counter += 1
    endwhile
    let g:S_allBuffers[g:S_HackDisplayBuffer].windowName=g:S_allBuffers[g:S_HackDisplayBuffer].windowName.counter
  endif
  let g:S_HackDisplayBuffer=bufnr(expand("%"))
  exec "sign place 1 line=1 name=blank buffer=".g:S_HackDisplayBuffer
  exec "belowright 1 split ".g:S_allBuffers[g:S_HackDisplayBuffer].windowName

  let g:S_allBuffers[g:S_HackDisplayBuffer].HackPromptBuffer=bufnr(expand("%"))

  "Make sure the prompt gets shown
  call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)

  setlocal winfixheight
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal buftype=nofile
  inoremap <silent> <buffer> <CR> <C-O>:call g:S_CarriageReturn(1)<CR>
  nnoremap <silent> <buffer> <CR> :call g:S_CarriageReturn(0)<CR>
  augroup HackHack
    autocmd CursorHoldI  <buffer> call g:S_UpdateTerminal(1, 1)
    autocmd CursorHold   <buffer> call g:S_UpdateTerminal(0, 1)
    autocmd CursorHold   *        call g:S_UpdateCurrentWindow()
    autocmd CursorHoldI  *        call g:S_UpdateCurrentWindow()
    autocmd BufEnter     *        call g:S_BufferSwitch()
  augroup END
  inoremap <silent> <buffer> <UP> <C-O>:call g:S_HistoryUp()<CR>
  inoremap <silent> <buffer> <DOWN> <C-O>:call g:S_HistoryDown()<CR>
  nnoremap <silent> <buffer> & :call g:S_ToggleAmperstyle()<CR>
  nnoremap <silent> <buffer> <UP>  @=":call g:S_HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <DOWN>  @=":call g:S_HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> k  @=":call g:S_HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> j  @=":call g:S_HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  inoremap <silent> <buffer> <TAB> <ESC>:call g:S_TabPress()<CR>
  nnoremap <silent> <buffer> / :call g:S_Search('/')<CR>
  nnoremap <silent> <buffer> ? :call g:S_Search('?')<CR>
  nnoremap <silent> <buffer> n @=":call g:S_DoSearch(0)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> N @=":call g:S_DoSearch(1)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <C-C> :call g:S_SendLine("\x03")<CR>
  inoremap <silent> <buffer> <C-C> <C-O>:call g:S_SendLine("\x03")<CR>
  nnoremap <silent> <buffer> <C-D> :call g:S_SendLine("\x04")<CR>
  inoremap <silent> <buffer> <C-D> <C-O>:call g:S_SendLine("\x04")<CR>
  nnoremap <silent> <buffer> gg :call g:S_GotoHistoryBeginning()<CR>
  nnoremap <silent> <buffer> G :call g:S_GotoHistoryEnd()<CR>
  nnoremap <silent> <buffer> '. :call g:S_GotoTempBuffer()<CR>
  nnoremap <silent> <buffer> ' :call g:S_GotoMark()<CR>
  nnoremap <silent> <buffer> m :call g:S_Mark()<CR>
  nnoremap <silent> <buffer> # I#<ESC>:call g:S_CarriageReturn(0)<CR>
  nnoremap <silent> <buffer> g? ?
  nnoremap <silent> <buffer> g/ /
  nnoremap <silent> <buffer> gn n
  nnoremap <silent> <buffer> gN N
  call g:S_DummyMap('m<ESC>')


  "stop updates from breaking window switcheg:S_allBuffers[g:S_HackDisplayBuffer]."
  call g:S_DummyMap('<C-W><ESC>')
  call g:S_MapNumbers()
  call g:S_MapRegisters()

  call g:S_GotoHackDisplay()
  call g:S_ExtendLines()
  call g:S_ReadAndUpdatePromptChar(200)
  call g:S_GotoHackPrompt()
  normal!dd
endfunction

function! g:S_BufferSwitch()
  let switchTo = winbufnr(winnr())
  if switchTo!=g:S_CurrentBuffer || g:S_WindowSwitched
    let g:S_NewBuffer = switchTo
    let g:S_WindowSwitched = 1
  endif
endfunction

function! g:S_UpdateCurrentWindow()
  if g:S_WindowSwitched==1
    let saveNewBuffer = g:S_NewBuffer
    if has_key(g:S_allBuffers,g:S_HackDisplayBuffer) && expand('%')!=g:S_allBuffers[g:S_HackDisplayBuffer].windowName
      "We left a hackbuffer (but not to its prompt)
      let saveWinnr=winnr()
      let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'browse'
      call g:S_HidePrompt()
      let g:S_HackDisplayBuffer = saveNewBuffer
    elseif !has_key(g:S_allBuffers, g:S_HackDisplayBuffer)
      "We left a nonhack buffer
      let g:S_HackDisplayBuffer = saveNewBuffer
    endif
    exec bufwinnr(g:S_NewBuffer)."wincmd w"
    let g:S_CurrentBuffer=g:S_NewBuffer
    let g:S_WindowSwitched = 0
  endif
endfunction

function! g:S_ClearUnfocusedEntries()
  return
  if buflisted(g:S_allBuffers[g:S_HackDisplayBuffer].windowName) && expand('%')!=g:S_allBuffers[g:S_HackDisplayBuffer].windowName && g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'browse'
      call g:S_HidePrompt()
    endif
    "Go back to window this was called from
    exec winnr('#')."wincmd w"
    let g:S_CurrentBuffer=winbufnr(winnr())
  endif
endfunction

function! g:S_GotoTempBuffer()
  if g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex>=0
    call g:S_RemoveArrow()
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

function! g:S_GotoHistoryBeginning()
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    return
  endif
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=len(g:S_allBuffers[g:S_HackDisplayBuffer].History)
  call g:S_GrabFromHistory()
  call g:S_AddArrow()
endfunction

function! g:S_GotoHistoryEnd()
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    return
  endif
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=0
  call g:S_GrabFromHistory()
  call g:S_AddArrow()
endfunction

function! g:S_NextSearch(direction)
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    return
  endif
  if g:S_allBuffers[g:S_HackDisplayBuffer].SearchMode=='?'
    let direction=-a:direction
  else
    let direction=a:direction
  endif
  let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount+direction
  let g:searchLocation = g:S_SmartMatch(g:S_allBuffers[g:S_HackDisplayBuffer].History,g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm,0, g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount)
  if g:searchLocation>=0 && g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount>0
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-g:searchLocation
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  else
    let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount-direction
  endif
endfunction

function! g:S_Search(mode)
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchMode=a:mode 
  let g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch=1
  call g:S_StoreTempBuffer()
  exec "normal!\"_dd"
  let g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar=a:mode
  call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)
  call feedkeys("a","n")
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex = 0
endfunction

function! g:S_GrabCommandLine(delete)
  let line = getline(1)
  if a:delete
    normal!"_dd
  endif
  return line
endfunction

function! g:S_DoSearch_FromCL()
  call g:S_GotoHackDisplay()
  match
  call g:S_GotoHackPrompt()
  call g:S_RemoveSearchArrow()
  let g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar = g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar
  "match ignores smartcase, so if smartcase is set and there are NO upper case
  "in search, we'll perform a case insenesitve search ourselves
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm = g:S_GrabCommandLine(1)
  let g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch = 0
  if g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm != ""
    call g:S_DoSearch(0)
    let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistory += [g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm]
  endif
endfunction

function! g:S_SmartMatch(expr, pat, start, count)
  let addCase=''
  if &smartcase && match(a:pat, '\C[A-Z]')!=-1
    let addCase='\C'
  endif
  return match(a:expr, addCase.a:pat, a:start, a:count)
endfunction

function! g:S_GetSearchLoc(reversed, incremental)
  let downward = ( g:S_allBuffers[g:S_HackDisplayBuffer].SearchMode=="/" && !a:reversed || g:S_allBuffers[g:S_HackDisplayBuffer].SearchMode=="?" && a:reversed)
  let reverseHistoryIndex=len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex
  let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=0
  let searchLocation=-2
  if a:incremental
    let searchTerm = g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm
  else
    let searchTerm = g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm
  endif
  while searchLocation<reverseHistoryIndex && searchLocation!=-1
    let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount+1
    let searchLocation = g:S_SmartMatch(g:S_allBuffers[g:S_HackDisplayBuffer].History, searchTerm, 0, g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount)
  endwhile
  if downward && searchLocation==reverseHistoryIndex
    let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount+1
    let searchLocation = g:S_SmartMatch(g:S_allBuffers[g:S_HackDisplayBuffer].History, searchTerm, 0, g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount)
  elseif !downward
    let g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount=g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount-1
    let searchLocation = g:S_SmartMatch(g:S_allBuffers[g:S_HackDisplayBuffer].History, searchTerm, 0, g:S_allBuffers[g:S_HackDisplayBuffer].MatchCount)
  endif
  return searchLocation
endfunction

function! g:S_GetSearchList(incremental)
  let resultList=[]
  let searchLocation=-2
  if a:incremental
    let searchTerm = g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm
  else
    let searchTerm = g:S_allBuffers[g:S_HackDisplayBuffer].SearchTerm
  endif
  let matchCount = 0
  while searchLocation!=-1
    let matchCount = matchCount + 1
    let searchLocation = g:S_SmartMatch(g:S_allBuffers[g:S_HackDisplayBuffer].History, searchTerm, 0, matchCount)
    if searchLocation!=-1
      let resultList += [searchLocation]
    endif
  endwhile
  return resultList
endfunction

function! g:S_DoIncrementalSearch(ampersearch)
  let temp = g:S_GrabCommandLine(0)
  "Only proceed if search term changed
  if g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm  == temp || g:S_allBuffers[g:S_HackDisplayBuffer].AmperTest == temp
    return
  endif

  let g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm = temp

  if !a:ampersearch
    if g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm != ""
      let searchLocation = g:S_GetSearchLoc(0, 1)
    endif

    call g:S_GotoHackDisplay()
    match
    call g:S_RemoveSearchArrow()

    if g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm != "" && searchLocation > 0
      let linenumber = g:S_ConvertHistoryToLineNumber(len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-searchLocation)
      call g:S_AddSearchArrow(linenumber)
      exec 'match Search /\%'.linenumber.'l.*\zs'.g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm.'/'
    endif
    call g:S_GotoHackPrompt()
  else
    match
    if g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm == ""
      call g:S_GotoHackDisplay()
      normal!zE
      call g:S_GotoHackPrompt()
      return
    endif
    let g:S_allBuffers[g:S_HackDisplayBuffer].searchList = g:S_GetSearchList(1)
    let lastSpot = 0
    call g:S_GotoHackDisplay()
    normal!zE
    for line in g:S_allBuffers[g:S_HackDisplayBuffer].searchList
      let lineY = g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine[line]
      if lineY>lastSpot+1
        exec (lastSpot+1).",".(lineY-1)."fold"
      endif
      let lastSpot = lineY
    endfor
    if g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint>lastSpot
      exec (lastSpot+1).",".(g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint-1)."fold"
    endif
    call g:S_GotoHackPrompt()
  endif
endfunction

function! g:S_DoSearch(reversed)
  let searchLocation = g:S_GetSearchLoc(a:reversed, 0)
  if searchLocation > 0
    call g:S_RemoveArrow()
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-searchLocation
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

let g:lastPathString=""
"eventully i should loop through all hhbuffers here
"
function! g:S_ReadAndUpdatePromptChar(howLong)
    " Don't do all this work if there's nothing to be read.
    if conque_term#get_instance().peak() == 0
      call g:S_SetToPotentialPrompt()
      echo ""
      return
    endif
    let startingInReadline=(g:S_allBuffers[g:S_HackDisplayBuffer].HackMode=='readline')
    
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode=='readline'
      call g:S_UnDashify()
    else
      echo ""
    endif
    let readOutput=conque_term#get_instance().read(a:howLong)
    "Read can move to a different buffer. We should move back
    call g:S_GotoHackDisplay()
    "Conqueterm will set the status line if it gets changed by a control char
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      call g:S_DashStatusLine()
      call g:S_Dashify()
    else
      call g:S_ExtendLines()
    endif
    let possiblePromptIndex=len(readOutput)-1
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'tab'
      let g:readOup= readOutput
      if match(readOutput, '\V'.g:S_allBuffers[g:S_HackDisplayBuffer].PreTab)!=-1
        let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'readline'
        call conque_term#get_instance().write("\x15")
      endif
    else
      let findSavePoint = match(readOutput,'\V[?1049h')
      if len(readOutput) > 1
        let g:S_allBuffers[g:S_HackDisplayBuffer].SaveOutput = readOutput
      endif
      if findSavePoint > -1
        let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'direct'
      endif
      if match(readOutput, '\V[?1049l') > findSavePoint
        let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'readline'
      endif
    endif
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      while readOutput[possiblePromptIndex]==" " && possiblePromptIndex>1
        let possiblePromptIndex=possiblePromptIndex-1
      endwhile

      if readOutput[possiblePromptIndex]!=" " && readOutput[possiblePromptIndex]!=""
        let g:S_allBuffers[g:S_HackDisplayBuffer].PotentialPromptChar=readOutput[possiblePromptIndex]
      endif
    endif
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'direct' && startingInReadline==1
      call g:S_HidePrompt()
    elseif g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline' && startingInReadline==0
      call g:S_ShowPrompt()
      startinsert!
      return 1
    endif
    return 0
endfunction

function! g:S_SetToPotentialPrompt()
  let oldPromptChar=g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar
  let g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar=g:S_allBuffers[g:S_HackDisplayBuffer].PotentialPromptChar
  if g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar==" " || g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar=="\n"
    let g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar="."
  endif
  if !g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    let g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar=g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar
  endif
  if g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar!=oldPromptChar
    call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)
  endif
endfunction

function! g:S_HidePrompt()
    exec "bunload!".g:S_allBuffers[g:S_HackDisplayBuffer].HackPromptBuffer
    call g:S_GotoHackDisplay()
    call g:S_UnDashify()
    exec "sign unplace * buffer=".g:S_HackDisplayBuffer
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'direct'
      exec "setlocal statusline=".g:S_allBuffers[g:S_HackDisplayBuffer].windowName."\\ (Direct\\ Input)"
      call g:S_MapDirectInputKeys()
    elseif g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'browse'
      exec "setlocal statusline=".g:S_allBuffers[g:S_HackDisplayBuffer].windowName."\\ (Browse\\ Mode)"
    elseif g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'tab'
      exec "setlocal statusline=".g:S_allBuffers[g:S_HackDisplayBuffer].windowName."\\ (Tab\\ Completion)"
      call g:S_MapTabKeys()
    endif
    stopinsert
endfunction

function! g:S_ShowPrompt()
  call g:S_UnmapDirectInputKeys()
  call g:S_SetBrowseMappings()
  let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode='readline'
  call g:S_DashStatusLine()
  call g:S_RestoreMarks()
  call g:S_Dashify()
  exec "belowright 1 split ".g:S_allBuffers[g:S_HackDisplayBuffer].windowName
  "This prompt might not have a sign yet, so let's reset it:
  call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)
  exec 'normal!"_ddi'.g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer
  setlocal winfixheight
  call g:S_AddArrow()
endfunction

function! g:S_UpdateTerminal(insert_mode, hackPrompt)
    if !has_key(g:S_allBuffers,g:S_HackDisplayBuffer)
      return
    endif

    if(a:insert_mode && a:hackPrompt && &incsearch && g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch)
      call g:S_DoIncrementalSearch(0)
    elseif g:S_Amperstyle
      call g:S_DoIncrementalSearch(1)
    endif

    let hackPrompt=a:hackPrompt
    let insert_mode=a:insert_mode
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'browse'
      return
    endif
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      call g:S_GotoHackDisplay()
    endif
    if g:S_ReadAndUpdatePromptChar(0)
      let hackPrompt=1
      startinsert!
      call g:S_GotoHackDisplay()
    endif
    if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex == 0 && g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      call g:S_JumpToLastLine()
      call g:S_RemoveArrow()
      let g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint = getpos('.')[1]
      call g:S_AddArrow()
    endif
    if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode == 'readline'
      call g:S_GotoArrowLine()
    endif
    if hackPrompt
      call g:S_GotoHackPrompt()
    endif
    call g:S_RestartUpdateCounter(insert_mode)
endfunction!

function! g:S_DoubleTab(capturedKeys)
    if a:capturedKeys!=""
      "TODO Nope, this NEEDS to go to temp buffer line
      call g:S_GotoArrowLine()
      let tempReg = getreg('"', 1)
      let regType = getregtype('"')
      exec "normal!yy"
      let g:S_allBuffers[g:S_HackDisplayBuffer].PreTab = @"[2:-2]
      call setreg('"',tempReg,regType)
      call conque_term#get_instance().write(a:capturedKeys."\t\t")
      let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'tab'
      let g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer = g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab
      call g:S_HidePrompt()
    else
      startinsert!
      silent call g:S_GotoHackPrompt()
    endif
endfunction

function! g:S_TabPress()
    let tempReg=getreg('"', 1)
    let regType=getregtype('"')
    exec "normal! A \<ESC>0d$"
    let capturedKeys=@"[0:-2]
    call setreg('"',tempReg,regType)
    silent call g:S_GotoHackDisplay()
    if g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab == capturedKeys
      call g:S_DoubleTab(capturedKeys)
      let g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab = ""
      return
    endif
    call conque_term#get_instance().write(capturedKeys."\t")
    let tabcompletevar=""
    let sanity=10
    while sanity > 0 && (tabcompletevar=="" || tabcompletevar==capturedKeys)
      let tabcompletevar=tabcompletevar.conque_term#get_instance().read(50,0)
      let sanity=sanity-1
    endwhile
    call conque_term#get_instance().write("\x15")
    call conque_term#get_instance().read(50,0)
    silent call g:S_GotoHackPrompt()
    exec "normal!\"_ddi".tabcompletevar
    if tabcompletevar == capturedKeys
      let g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab = capturedKeys
    else
      let g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab = ""
    endif
    startinsert!
endfunction

function! g:S_RestartUpdateCounter(insert_mode)
    if a:insert_mode
        call feedkeys("\<C-o>f\e", "n")
    else
        call feedkeys("f\e", "n")
    endif
endfunction


function! g:S_SendLine(line)
  let g:lineSent=a:line
  silent call g:S_GotoHackDisplay()
  call g:S_JumpToLastLine()
  let g:S_allBuffers[g:S_HackDisplayBuffer].History=g:S_allBuffers[g:S_HackDisplayBuffer].History+[a:line[0:-2]]
  let g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint=getpos('.')[1]
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine=g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine+[g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint]
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=0
  call conque_term#get_instance().write(a:line)
  call g:S_RemoveArrow()
  call g:S_ReadAndUpdatePromptChar(80)
  call g:S_JumpToLastLine()
  let g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint=getpos('.')[1]
  if g:S_allBuffers[g:S_HackDisplayBuffer].HackMode=='readline'
    call g:S_AddArrow()
  endif
  silent call g:S_GotoHackPrompt()
endfunction

function! g:S_CarriageReturn(insertMode)
  "prevent carriage return spam
  let g:S_allBuffers[g:S_HackDisplayBuffer].FirstTab = ""
  while getchar(1)==13 "carriage return
    call getchar(0)
  endwhile
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch!=0
    call g:S_DoSearch_FromCL()
    call feedkeys("\<ESC>",'n')
    let g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar=g:S_allBuffers[g:S_HackDisplayBuffer].NormalPromptChar
    call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)
    return
  endif
  call g:S_EraseOldBufferMarker()
  let g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer=""
  let g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex=-1
  let capturedKeys=g:S_GrabCommandLine(1)
  call g:S_SendLine(capturedKeys."\n")
  call g:S_RestartUpdateCounter(a:insertMode)
endfunction

function! g:S_EraseOldBufferMarker()
  sign unplace 4
endfunction


function! g:S_StoreTempBuffer()
  if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex!=0
    let historyLine=g:S_allBuffers[g:S_HackDisplayBuffer].History[-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex]
  else
    let historyLine = substitute(g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer, "\n.*", "", "")
  endif
  let commandLine=g:S_GrabCommandLine(1)
  if historyLine!=commandLine && historyLine." "!=commandLine
    call g:S_EraseOldBufferMarker()
    let g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer = commandLine
    if commandLine!="" && commandLine!=" "
      let g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex=g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex
    else
      let g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex=-1
    endif
  endif
endfunction

function! g:S_ToggleAmperstyle()
  let g:S_Amperstyle = !g:S_Amperstyle
  "Amperstyle has a & in the prompt
  call g:S_ChangePrompt(g:S_allBuffers[g:S_HackDisplayBuffer].PromptChar)
  if g:S_Amperstyle
    let g:S_allBuffers[g:S_HackDisplayBuffer].searchList = []
  endif
endfunction

function! g:S_SearchHistoryUp()
  if g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex < len(g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistory)
    let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex = g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex+1
    call g:S_GrabFromSearchHistory()
  endif
endfunction

function! g:S_SearchHistoryDown()
  let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex = g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex-1
  if g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex < 0
    let g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex = 0
  else
    call g:S_GrabFromSearchHistory()
  endif
endfunction

function! g:S_AmperstyleUp()
  let amperIndex =  index(g:S_allBuffers[g:S_HackDisplayBuffer].searchList, len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex)
  if amperIndex != 0
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    "-1 will handle the zeropoint default index which doesn't whow up in the searchList
    "Keeping this -1 will go to the bottom of search list which is what we want
    if amperIndex != -1
      let amperIndex -= 1
    endif
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex = len(g:S_allBuffers[g:S_HackDisplayBuffer].History) - g:S_allBuffers[g:S_HackDisplayBuffer].searchList[amperIndex]
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
    let temp = g:S_GrabCommandLine(0)
    let g:S_allBuffers[g:S_HackDisplayBuffer].AmperTest = temp
    if temp == g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm
      match
    else
      exec 'match Search /^.\{-}\zs'.g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm.'/'
    endif
  endif
endfunction

function! g:S_AmperstyleDown()
  let g:amperIndex =  index(g:S_allBuffers[g:S_HackDisplayBuffer].searchList, len(g:S_allBuffers[g:S_HackDisplayBuffer].History)-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex)
  if g:amperIndex != -1
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    "-1 will handle the zeropoint default index which doesn't whow up in the searchList
    "Keeping this -1 will go to the bottom of search list which is what we want
    if g:amperIndex < len(g:S_allBuffers[g:S_HackDisplayBuffer].searchList) - 1
      let g:amperIndex += 1
      let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex = len(g:S_allBuffers[g:S_HackDisplayBuffer].History) - g:S_allBuffers[g:S_HackDisplayBuffer].searchList[g:amperIndex]
    else
      let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex = 0
    endif
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
    let temp = g:S_GrabCommandLine(0)
    let g:S_allBuffers[g:S_HackDisplayBuffer].AmperTest = temp
    if temp == g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm
      match
    else
      exec 'match Search /^.\{-}\zs'.g:S_allBuffers[g:S_HackDisplayBuffer].IncSearchTerm.'/'
    endif
  endif
endfunction

function! g:S_HistoryUp()
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    call g:S_SearchHistoryUp()
    return
  endif
  if g:S_Amperstyle && g:S_allBuffers[g:S_HackDisplayBuffer].searchList != []
    call g:S_AmperstyleUp()
    return
  endif
  if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex<len(g:S_allBuffers[g:S_HackDisplayBuffer].History)
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex+1
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

function! g:S_HistoryDown()
  if g:S_allBuffers[g:S_HackDisplayBuffer].TypingSearch
    call g:S_SearchHistoryDown()
    return
  endif 
  if g:S_Amperstyle && g:S_allBuffers[g:S_HackDisplayBuffer].searchList != []
    call g:S_AmperstyleDown()
    return
  endif
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex-1
  if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex<0
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex=0
  else
    call g:S_GrabFromHistory()
  endif
  call g:S_AddArrow()
endfunction

function! g:S_GotoArrowLine()
  exec "normal!".g:S_GetArrowLine()."gg"
endfunction

function! g:S_GetArrowLine()
  return g:S_ConvertHistoryToLineNumber(g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex)
endfunction

function g:S_ConvertHistoryToLineNumber(history)
  if a:history==0
    return g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint
  else
    return g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine[-a:history]
  endif
endfunction

function! g:S_RemoveSearchArrow()
  exec "sign unplace ".5
endfunction

function! g:S_RemoveArrow()
  let lineNum=g:S_GetArrowLine()
  if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex==g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex
    exec "sign place 4 line=".lineNum." name=dot buffer=".g:S_HackDisplayBuffer
  else
    exec "sign place 1 line=".lineNum." name=blank buffer=".g:S_HackDisplayBuffer
  endif
  exec "sign unplace ".2
endfunction

function! g:S_AddSearchArrow(lineNum)
  exec "normal!".a:lineNum."gg"
  exec "sign place 5 line=".a:lineNum." name=searcharrow buffer=".g:S_HackDisplayBuffer
  sign unplace 1
endfunction

function! g:S_AddArrow()
  let lineNum=g:S_GetArrowLine()
  exec "normal!".lineNum."gg"
  exec "sign place 2 line=".lineNum." name=doublearrow buffer=".g:S_HackDisplayBuffer
  sign unplace 1
endfunction

function! g:S_GrabFromSearchHistory()
  if g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex == 0
    normal! gg"_dG
  else
    let historyLine=g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistory[-g:S_allBuffers[g:S_HackDisplayBuffer].SearchHistoryIndex]
    normal! gg"_dG
    exec "normal!A".historyLine
    normal! gg$
  endif
endfunction

function! g:S_GrabFromHistory()
  "The bottom line always retrieves the temp buffer
  if g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex==g:S_allBuffers[g:S_HackDisplayBuffer].TempBufferIndex || g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex==0
    normal! gg"_dG
    exec "normal!A".g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer
    normal! gg$
  else
    let historyLine=g:S_allBuffers[g:S_HackDisplayBuffer].History[-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex]
    normal! gg"_dG
    exec "normal!A".historyLine
    normal! gg$
  endif
endfunction

function! g:S_MapNumbers()
  "This stops all numbers under 10million, including those with zeros, but not 0 itself from
  "breaking when we check term.
  "will have problems though.
  call g:S_DummyMap('1000000<ESC>')
  call g:S_DummyMap('2000000<ESC>')
  call g:S_DummyMap('3000000<ESC>')
  call g:S_DummyMap('4000000<ESC>')
  call g:S_DummyMap('5000000<ESC>')
  call g:S_DummyMap('6000000<ESC>')
  call g:S_DummyMap('7000000<ESC>')
  call g:S_DummyMap('8000000<ESC>')
  call g:S_DummyMap('9000000<ESC>')
endfunction

function! g:S_MapRegisters()
  let lowercase = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
  let uppercase = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
  let numbers = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  let others = ['"', ":", ".", "%", "#", "=", "*", "+", "~", "_", "-", "/"]


  let registers = lowercase + uppercase + numbers + others
  for register in registers
    call g:S_DummyMap('"'.register.'<ESC')
  endfor
endfunction

"Dummy maps shouldn't affect anything except that they will stop cursorhold
"from triggering in the middle of their key sequence.
function! g:S_DummyMap(mapping)
  if maparg(a:mapping, "n") == ""
    exec "nnoremap <unique> ".a:mapping." ".a:mapping
  endif
endfunction

function! g:S_Dashify()
  call g:S_ExtendLines()
  silent exec("%s/^/¦/e")
endfunction

function! g:S_UnDashify()
  silent exec("%s/^¦//e")
endfunction

function! g:S_ExtendLines()
  normal! H
  let topLine=getpos('.')[1]
  normal! L
  let numLines=getpos('.')[1]-topLine+1
  if numLines<winheight(winnr())
    exec "normal!".(winheight(winnr())-numLines)."o\<ESC>"
  endif
  return
endfunction

function! g:S_JumpToLastLine()
  normal!G$
  while getpos('.')[2]==1
    normal!k$
  endwhile
  normal!zb
endfunction

function! g:S_ChangePrompt(promptChar)
  sign unplace 3
  if g:S_Amperstyle
    exec "sign define prompt text=& texthl=WarningMsg"
  else
    exec "sign define prompt text=".a:promptChar." texthl=HHPrompt"
  endif
  exec "sign place 3 line=1 name=prompt buffer=".g:S_allBuffers[g:S_HackDisplayBuffer].HackPromptBuffer
endfunction

function! g:S_Mark()
  let num=getchar()
  let char=nr2char(num)
  call g:S_GotoHackDisplay()
    call g:S_GotoArrowLine()
    silent! exec "normal!m".char
    silent! exec "sign unplace ".num
    silent! exec "sign place ".num." line=".g:S_GetArrowLine()." name=".char." buffer=".g:S_HackDisplayBuffer
  call g:S_GotoHackPrompt()
endfunction

function! g:S_GotoMark()
  let char=nr2char(getchar())
  call g:S_GotoHackDisplay()
    silent! exec "normal!'".char
    call g:S_HistoryFromCursorPos()
  call g:S_GotoHackPrompt()
endfunction

function! g:S_HistoryFromCursorPos()
  let cursorline = getpos('.')[1]
  call g:S_GotoHackPrompt()
  call g:S_StoreTempBuffer()
  call g:S_GotoHackDisplay()
  call g:S_RemoveArrow()
  if cursorline==g:S_allBuffers[g:S_HackDisplayBuffer].ZeroArrowPoint
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex = 0
  else
    let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex = 1
    while g:S_allBuffers[g:S_HackDisplayBuffer].HistoryLine[-g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex]>cursorline && g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex<len(g:S_allBuffers[g:S_HackDisplayBuffer].History)
      let g:S_allBuffers[g:S_HackDisplayBuffer].HistoryIndex+=1
    endwhile
  endif
  call g:S_GotoHackPrompt()
  call g:S_GrabFromHistory()
  call g:S_GotoHackDisplay()
  call g:S_AddArrow()
endfunction

function! g:S_MapTabKeys()
  call g:S_MapDirectInputKeys()
  silent exec "nnoremap <buffer> <C-C> :call g:S_TabCC()<CR>"
endfunction
      
function! g:S_TabCC()
  call conque_term#get_instance().write(nr2char(3))
  let g:S_allBuffers[g:S_HackDisplayBuffer].HackMode = 'readline'
  call conque_term#get_instance().write("\x15")
  let g:S_allBuffers[g:S_HackDisplayBuffer].TempBuffer = ''
  call g:S_ShowPrompt()
  startinsert!
endfunction

function! g:S_MapDirectInputKeys()
  let g:i=1
  while g:i<256
    if g:i==124
      silent exec "nnoremap <nowait> <buffer> \\| :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==9
      silent exec "nnoremap <nowait> <buffer> <TAB> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==10
      silent exec "nnoremap <nowait> <buffer> <C-J> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==22
      silent exec "nnoremap <nowait> <buffer> <C-V> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==32
      silent exec "nnoremap <nowait> <buffer> <SPACE> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    else
      silent exec "nnoremap <nowait> <buffer> ".nr2char(g:i)." :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    endif
    let g:i+=1
  endwhile
endfunction

function! g:S_UnmapDirectInputKeys()
  let i=1
  while i<256
    if i==124
      silent! exec "nunmap <buffer> \\|"
    elseif i==9
      silent! exec "nunmap <buffer> <TAB>"
    elseif i==10
      silent! exec "nunmap <buffer> <C-J>"
    elseif i==22
      silent! exec "nunmap <buffer> <C-V>"
    elseif i==32
      silent! exec "nunmap <buffer> <SPACE>"
    else
      silent! exec "nunmap <buffer> ".nr2char(i)
    endif
    let i+=1
  endwhile
endfunction

function! g:S_GotoHackPrompt()
  let g:S_CurrentBuffer = bufwinnr(g:S_allBuffers[g:S_HackDisplayBuffer].HackPromptBuffer)
  exec bufwinnr(g:S_allBuffers[g:S_HackDisplayBuffer].HackPromptBuffer)."wincmd w"
endfunction

function! g:S_GotoHackDisplay()
  let g:S_CurrentBuffer = bufwinnr(g:S_HackDisplayBuffer)
  exec bufwinnr(g:S_HackDisplayBuffer)."wincmd w"
endfunction

function! g:S_DashStatusLine()
  setlocal statusline=%#HHBorder#-\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ %<
endfunction

function! g:S_SetBrowseMappings()
  nnoremap <buffer> i :call g:S_ShowPrompt()<CR>i
  nnoremap <buffer> I :call g:S_ShowPrompt()<CR>I
  nnoremap <buffer> a :call g:S_ShowPrompt()<CR>a
  nnoremap <buffer> A :call g:S_ShowPrompt()<CR>A
  nnoremap <buffer> p :call g:S_ShowPrompt()<CR>:exec 'normal!"'.v:register.'p'<CR>
  nnoremap <buffer> P :call g:S_ShowPrompt()<CR>:exec 'normal!"'.v:register.'p'<CR>
endfunction

function! g:S_RestoreMarks()
  "display
  let lowercase=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
  let uppercase=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
  let marks=lowercase+uppercase+["."]
  for mark in marks
    call g:S_RestoreMark(mark)
  endfor
endfunction

function! g:S_RestoreMark(mark)
  let cursorline = getpos("'".a:mark)[1]
  if cursorline>0
    silent! exec "sign place ".char2nr(a:mark)." line=".cursorline." name=".a:mark." buffer=".g:S_HackDisplayBuffer
  endif
endfunction

let &cpo = g:S_save_cpo
unlet g:S_save_cpo
