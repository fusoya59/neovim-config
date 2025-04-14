return {
  "numToStr/Comment.nvim",
  lazy = false, -- or true if you only want it to load on certain events
  config = function()
    require("Comment").setup()
  end,
}
