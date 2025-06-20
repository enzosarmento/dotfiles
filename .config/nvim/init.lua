-- Plugin manager: Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'IogaMaster/neocord',
        event = "VeryLazy"
    },
    { 'wakatime/vim-wakatime', lazy = false },
    { "sainnhe/sonokai" },
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "ryanoasis/vim-devicons" },
    { "sheerun/vim-polyglot" },
    { "preservim/nerdtree" },
    { "tiagofumo/vim-nerdtree-syntax-highlight" },
    { "Xuyuanp/nerdtree-git-plugin" },
    { "neoclide/coc.nvim", branch = "release" },
    { "dense-analysis/ale" },
    { "honza/vim-snippets" },
    { "jiangmiao/auto-pairs" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
})

-- Global Options
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 2
vim.opt.updatetime = 100
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autoread = true
vim.cmd("filetype plugin indent on")

-- Theme
vim.g.sonokai_style = "andromeda"
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 0
vim.g.sonokai_diagnostic_line_highlight = 1
vim.g.sonokai_current_word = "bold"
vim.opt.termguicolors = true
vim.cmd("colorscheme sonokai")

-- Transparência
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

-- Keymaps
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "te", ":tabedit<CR>", opts)
map("n", "ty", ":bnext<CR>", opts)
map("n", "tr", ":bprevious<CR>", opts)
map("n", "td", ":bd<CR>", opts)
map("n", "th", ":split<CR>", opts)
map("n", "tv", ":vsplit<CR>", opts)
map("n", "tt", ":q<CR>", opts)
map("n", "<C-a>", ":NERDTreeToggle<CR>", opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- The setup config table shows all available config options with their default values:
require("neocord").setup({
    -- General options
    logo                = "auto",                     -- "auto" or url
    logo_tooltip        = nil,                        -- nil or string
    main_image          = "language",                 -- "language" or "logo"
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer
    global_timer        = false,                      -- if set true, timer won't update when any event are triggered
    buttons             = nil,                        -- A list of buttons (objects with label and url attributes) or a function returning such list.

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    terminal_text       = "Using Terminal",           -- Format string rendered when in terminal mode.
})

-- COC Explorer
map("n", "<space>e", ":CocCommand explorer<CR>", opts)
map("n", "<space>ef", ":CocCommand explorer --preset floating<CR>", opts)
map("n", "<space>eb", ":CocCommand explorer --preset buffer<CR>", opts)

-- COC configurações básicas (completions e navegação)
vim.g.coc_global_extensions = {
  'coc-snippets', 'coc-explorer'
}

vim.g.coc_explorer_global_presets = {
  floating = {
    position = "floating",
    ["open-action-strategy"] = "sourceWindow",
  },
  buffer = {
    sources = {
      { name = "buffer", expand = true },
    },
  },
}

vim.cmd([[
inoremap <silent><expr> <TAB> pumvisible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

-- ALE config
vim.g.ale_fixers = { ["*"] = { "trim_whitespace" } }
vim.g.ale_fix_on_save = 1

-- Autocmd para destacar palavra sob o cursor
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    if col > 1 and not line:sub(col - 1, col - 1):match("[%s%p]") then
      vim.cmd("match Search /\\<" .. vim.fn.expand("<cword>") .. "\\>/")
    else
      vim.cmd("match none")
    end
  end,
})

