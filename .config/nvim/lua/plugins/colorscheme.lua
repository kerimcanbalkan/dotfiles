return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "soft",
      transparent_background_level = 2,
    })
  end,
}, {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "everforest",
  },
}
