local M = {}

---@param item { name: string, commands: string[] }
function M.run(item)
  vim.notify("Running: " .. item.name)

  vim.schedule(function()
    for _, cmd in ipairs(item.commands) do
      vim.cmd(cmd)
    end
  end)
end

return M
