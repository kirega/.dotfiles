M = {}

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

M.augroup = function(name, callback)
  vim.cmd("augroup " .. name)
  vim.cmd("autocmd!")
  callback(function(cmd)
    vim.cmd("autocmd " .. cmd)
  end)
  vim.cmd("augroup END")
end

return M
