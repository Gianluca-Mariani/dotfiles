local opt = vim.opt

-- Line numbers
opt.nu = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search settings
opt.hlsearch = false
opt.incsearch = true

-- Appearance & Behavior
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50

-- Persistent Undo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Keep cursor as a solid block in all modes
opt.guicursor = ""

-- Copy to system clipboard
opt.clipboard = "unnamedplus"
