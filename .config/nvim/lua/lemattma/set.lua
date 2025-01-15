vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.isfname:append("@-@")

--vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.splitright = true

-- Custom Settings
vim.o.undofile   = true -- enable persistent undo
vim.o.lazyredraw = true -- do not redraw everything everytime
vim.o.visualbell = true -- silence please
vim.o.expandtab  = true -- force use of spaces as tab
vim.o.tabstop    = 2    -- number of spaces for indentation
vim.o.shiftwidth = 2    -- used with tabstop and >> << == commands
vim.o.mouse      = 'a'  -- enable mouse actions
vim.o.number     = true -- show number of the line
vim.o.scrolloff  = 10   -- number of lines always above or below the cursor
vim.o.cursorline = true -- highlight the line where is the cursor
vim.o.showmatch  = true -- highlight the sibling block mark: (), [], {}
