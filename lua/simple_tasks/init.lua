local core = require("simple_tasks.core")

local M = {}

M.config = {
  picker = "snacks", -- snacks | ui
  title = "Project Tasks",
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function get_picker(name)
  local ok, picker = pcall(require, "nvim_tasks.pickers." .. name)
  if ok then
    return picker
  end
end

function M.pick()
  local tasks, err = core.read_tasks()
  if not tasks then
    vim.notify(err, vim.log.levels.WARN)
    return
  end

  local items = core.normalize(tasks)

  local picker = get_picker(M.config.picker)
    or get_picker("ui")

  picker.pick(items, {
    title = M.config.title,
  })
end

return M
