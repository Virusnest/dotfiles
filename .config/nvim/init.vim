"Default Configs
:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

"Pluggins
call plug#begin()

	Plug 'catppuccin/nvim', {'as': 'catppuccin'}
	Plug 'itchyny/lightline.vim'
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-commentary'
	Plug 'mattn/emmet-vim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'romgrk/barbar.nvim'
	Plug 'renerocksai/telekasten.nvim'
	Plug 'glepnir/dashboard-nvim'
	Plug 'danilamihailov/beacon.nvim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'neoclide/coc.nvim'

call plug#end()
"custom Configs

let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
let g:lightline = {'colorscheme': 'catppuccin'}

"keybinds
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

lua << EOF
require("catppuccin").setup({
	transparent_background = true,
	term_colors = false,
	compile = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		barbar = true,
		beacon = true,
		gitgutter = true
		-- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
	},
	color_overrides = {},
	highlight_overrides = {},
})
EOF

colorscheme catppuccin

