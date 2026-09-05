return {
  'cormacrelf/dark-notify',
  dependencies = {
    'mcncl/alabaster.nvim',
  },
  init = function()
    local dn = require 'dark_notify'
    local changeTheme = function(theme)
      local ala = require 'alabaster'
      ala.setup {
        style = theme,
      }
    end
    dn.run {
      onchange = changeTheme,
    }
  end,
}
