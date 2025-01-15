return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "comment",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "elixir",
          "erlang",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "graphql",
          "hcl",
          "html",
          "http",
          "ini",
          "java",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "latex",
          "lua",
          "luadoc",
          "luap",
          "luau",
          "make",
          "markdown",
          "markdown_inline",
          "ninja",
          "passwd",
          "proto",
          "python",
          "ruby",
          "rust",
          "sql",
          "terraform",
          "typescript",
          "vim",
          "vimdoc",
        },
        sync_install = false,
        auto_install = true,
        indent = {
          enable = true
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
}
