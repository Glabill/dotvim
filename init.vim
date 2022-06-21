set encoding=UTF-8
set number
set relativenumber
set mouse+=a
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set pyxversion=3
set scrolloff=10
set updatetime=100
set cursorline
set nocursorcolumn
set ignorecase
set noswapfile
set numberwidth=5
set colorcolumn=0
"set noshowmode
"set laststatus=2
"set showtabline=2
set guioptions-=e
set signcolumn=yes

let mapleader=" "

if (has("termguicolors"))
  set termguicolors
endif

filetype plugin indent on
call plug#begin("~/.vim/plugged")

" Plugin Section
Plug 'folke/tokyonight.nvim'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'feline-nvim/feline.nvim'
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
" Plug 'tpope/vim-flagship'
Plug 'leafoftree/vim-vue-plugin'
" Plug 'posva/vim-vue'
" Plug 'pangloss/vim-javascript'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'sainnhe/everforest'
Plug 'doums/darcula'
Plug 'sainnhe/sonokai'
Plug 'frenzyexists/aquarium-vim', { 'branch': 'develop' }
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'arcticicestudio/nord-vim',
Plug 'arzg/vim-colors-xcode',
Plug 'github/copilot.vim'
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile--production'}
" Plug 'gcmt/taboo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'nvim-lua/plenary.nvim' " required by telescope
Plug 'sharkdp/fd' " required by telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'startup-nvim/startup.nvim'
" Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" Config Section
syntax enable
let g:everforest_background = 'soft'
let g:everforest_enable_italic = 1
let g:everforest_transparent_background = 1
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_contrast_dark = 'soft'
let g:tokyonight_style = "storm"
let g:sonokai_style = "atlantis"
let g:sonokai_enable_italic = "1"
set background=dark
colorscheme everforest 

" Emmet config
let g:user_emmet_leader_key = '<C-F>'


" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

nnoremap <leader>v <cmd>vsplit<cr>
nnoremap <leader>s <cmd>split<cr>
nnoremap <leader>n <cmd>noh<cr>

nnoremap <leader>cd :tcd 

" move between splits with ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" rearrange splits with leader+hjkl
nnoremap <leader>h <C-w>H<CR>
nnoremap <leader>j <C-w>J<CR>
nnoremap <leader>k <C-w>K<CR>
nnoremap <leader>l <C-w>L<CR>

" Search mappings
nnoremap <C-s> :%s/
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep_args<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope file_browser hidden=true<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

nnoremap <leader>ss <cmd>:call MakeSession()<cr>
nnoremap <leader>sl <cmd>:call RestoreSession()<cr>

nnoremap <leader>fn <cmd>lua require('startup').new_file()<cr>

function! MakeSession()
  exe "mksession! ~/vim-sessions/session.vim"
endfunction

function! RestoreSession()
  exe "source ~/vim-sessions/session.vim"
endfunction


" new tab
nnoremap <leader>t :tabnew<cr>

set listchars=space:·
" au BufEnter * if &buftype set list
nnoremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" Automatically open quickfixlist after grep and the likes
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

set noshowmode
set wildignore+=*/node_modules/**

command -nargs=1 Sch noautocmd vimgrep /<args>/gj `git ls-files` | cw


" Syntastic config

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_stl_format = "%E{%#ErrorFloat# %e}%W{%#WarningFloat#   %w}" 
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_loc_list_height = 3

nnoremap <leader>en :lnext<cr>
nnoremap <leader>ef :lfirst<cr>
nnoremap <leader>ep :lprev<cr>

" open errors list (populated location list)
nnoremap <leader>ee :Errors<CR>

" close location list
nnoremap <leader>ec :lclose<CR>

" refresh syntax highlighting on F12
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" let g:indentLine_color_term = 000
" let g:indentLine_char = '│'
set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h14
let g:neovide_cursor_trail_length=1.0
let g:neovide_cursor_animation_length=0.07
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_vfx_particle_density=0.0
let g:neovide_transparency=1.0

let g:tabprefix=' '

let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = 'NerdTree'
let g:NERDTreeIgnore = []
let g:NERDTreeMinimalUI = 1

set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    let s .= '%#TabLineFill#'
    let s .= ' '
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#PmenuThumb#' " WildMenu
    else
      let s .= '%#PmenuSbar#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ' | ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ' | $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    let s .= ' '
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction

function! Currentmode()
  let bs = 80
  let s = ''
  let m = mode()
  if m == 'n'
    let s = winwidth(0)>bs ? 'NORMAL' : 'N'
  elseif m == 'i'
    let s = winwidth(0)>bs ? 'INSERT' : 'I'
  elseif m ==# "V"
    let s = winwidth(0)>bs ? 'V·LINE' : 'V·L'
  elseif m ==# "v"
    let s = winwidth(0)>bs ? 'VISUAL' : 'V'
  elseif m == "\<C-v>"
    let s = winwidth(0)>bs ? 'V·BLOCK' : 'V·B'
  elseif m ==# 's'
    let s = winwidth(0)>bs ? 'SELECT' : 'S'
  elseif m ==# 'S'
    let s = winwidth(0)>bs ? 'S·LINE' : 'S·L'
  elseif m == 'R'
    let s = winwidth(0)>bs ? 'REPLACE' : 'R'
  elseif m == 'T'
    let s = winwidth(0)>bs ? 'TERMINAL' : 'T'
  elseif m == 'Rv'
    let s = winwidth(0)>bs ? 'R·VISUAL' : 'V·R'
  elseif m == 'c'
    let s = winwidth(0)>bs ? 'COMMAND' : 'Cmd'
  endif
  return s
endfunction

lua << EOF

require("startup").setup{
  header = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = {
                                                          
[[@@@  @@@  @@@@@@@@   @@@@@@   @@@  @@@  @@@  @@@@@@@@@@   ]],
[[@@@@ @@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@  @@@@@@@@@@@  ]],
[[@@!@!@@@  @@!       @@!  @@@  @@!  @@@  @@!  @@! @@! @@!  ]],
[[!@!!@!@!  !@!       !@!  @!@  !@!  @!@  !@!  !@! !@! !@!  ]],
[[@!@ !!@!  @!!!:!    @!@  !@!  @!@  !@!  !!@  @!! !!@ @!@  ]],
[[!@!  !!!  !!!!!:    !@!  !!!  !@!  !!!  !!!  !@!   ! !@!  ]],
[[!!:  !!!  !!:       !!:  !!!  :!:  !!:  !!:  !!:     !!:  ]],
[[:!:  !:!  :!:       :!:  !:!   ::!!:!   :!:  :!:     :!:  ]],
[[ ::   ::   :: ::::  ::::: ::    ::::     ::  :::     ::   ]],
[[::    :   : :: ::    : :  :      :      :     :      :    ]],
                                                          
    },
    highlight = "Title",
    default_color = "#FFFFFF",
    oldfiles_amount = 0,
  },
  body = {
    type = "oldfiles",
    oldfiles_directory = true,
    align = "center",
    fold_section = true,
    title = "Old Files",
    content = {},
    highlight = "String",
    default_color = "#FFFFFF",
    oldfiles_amount = 5,
  },
  body_1 = {
    type="mapping",
    align = "center",
    fold_section = false,
    title = "Commands",
    margin = 10,
    content = {
      { "   Find File", "Telescope find_files hidden=true", "SPC ff" },
      { "   Recent Files", "Telescope oldfiles hidden=true", "SPC fo" },
      { "   Find Word", "Telescope live_grep hidden=true", "SPC fg" },
      { "   File Browser", "Telescope file_browser hidden=true", "SPC fb" },
      { "   New File", "lua require'startup'.new_file()", "SPC fn" },
      { "   Last Session", ":call RestoreSession()", "SPC sl" },
    },
    highlight = "Keyword",
    default_color = "#FFFFFF",
    oldfiles_amount = 0,
  },
  body_2 = {
    type = "text",
    align = "center",
    content = function()
      local str ="ﱮ  " .. vim.fn.getcwd()
      return {str}
    end,
    highlight = "Comment",
    default_color = "#FFFFFF",
  },
  options = {
    after = function()
      require("startup.utils").oldfiles_mappings()
    end,
    mapping_keys = true,
    cursor_column = 0,
    disable_statuslines = true,
    highlight = "Comment",
    default_color = "#FFFFFF",
    oldfiles_amount = 0,
  },
  parts = { "header", "body_1", "body_2" },
}

require'nvim-treesitter.configs'.setup{
  ensure_installed = {'javascript', 'typescript', 'vue', 'scss', 'html', 'vim', 'markdown', 'css'},
  highlight = {
    enable = true,
  },
}

if (vim.g.colors_name == 'everforest') then
  local custom = require'lualine.themes.everforest'
  custom.inactive.c.bg = '#465259'
  custom.normal.c.bg = '#465259'
end


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = vim.g.colors_name == custom or 'auto',
    component_separators = { left = ' ', right = ' '},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {{'%{Currentmode()}'}},
    lualine_b = {{'%{" " . split(getcwd(), "/")[-1]}', separator = ''}, {'branch', icon = 'שׂ'}},
    lualine_c = {{'SyntasticStatuslineFlag', separator = ''}, {'%{pathshorten(@%, 2)}'}, 'diff'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

require('telescope').load_extension "file_browser"
require('telescope').load_extension "live_grep_args"


local custom_actions = {}
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function custom_actions.fzf_multi_select_edit(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    local picker = action_state.get_current_picker(prompt_bufnr)
    for _, entry in ipairs(picker:get_multi_selection()) do
        vim.cmd(string.format("%s %s", ":e!", entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_edit(prompt_bufnr)
  end
end

function custom_actions.fzf_multi_select_tab(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    local picker = action_state.get_current_picker(prompt_bufnr)
    for _, entry in ipairs(picker:get_multi_selection()) do
        vim.cmd(string.format("%s %s", ":tabnew!", entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_tab(prompt_bufnr)
  end
end

function custom_actions.fzf_multi_select_split(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    local picker = action_state.get_current_picker(prompt_bufnr)
    for _, entry in ipairs(picker:get_multi_selection()) do
        vim.cmd(string.format("%s %s", ":vsplit!", entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_vsplit(prompt_bufnr)
  end
end


require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" },
    mappings = { 
      i = {
        ['<esc>'] = actions.close,
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<c-e>'] = custom_actions.fzf_multi_select_edit,
        ['<c-t>'] = custom_actions.fzf_multi_select_tab,
        ['<c-v>'] = custom_actions.fzf_multi_select_split,
      },
      n = {
        ['<esc>'] = actions.close,
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<c-e>'] = custom_actions.fzf_multi_select_edit,
        ['<c-t>'] = custom_actions.fzf_multi_select_tab,
        ['<c-v>'] = custom_actions.fzf_multi_select_split,
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
      },
    },
    live_grep_args = {
      auto_quoting = false,
    },
  },
}

EOF
