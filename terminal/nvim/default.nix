{pkgs,...}:
{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];

    extraLuaConfig = ''
    local opt = vim.opt
    local g = vim.g 
    -- global
    g.mapleader = " "

    -- options
    opt.showmode = true
    opt.expandtab = true
    opt.shiftwidth = 2
    opt.smartindent = true
    opt.tabstop = 2
    opt.softtabstop = 2

    opt.ignorecase = true
    opt.smartcase = true
    opt.mouse = "a"

    -- numbers
    opt.number = true
    opt.relativenumber = true
    opt.numberwidth = 2

    -- opt.ruler = false
    opt.shortmess:append "sI"

    opt.signcolumn = "yes"
    opt.splitbelow = true
    opt.splitright = true
    -- opt.termguicolors = true
    opt.timeoutlen = 400
    opt.undofile = true

    -- interval for writing swap file to disk, also used by gitsigns
    opt.updatetime = 25
    '';
  };
}