-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "python",
      "lua",
      "vim",
      "nim",
      "asm",
      "bash",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
