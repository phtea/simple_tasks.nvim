---@class SimpleTasksConfig
---@field picker string Picker strategy name ("ui" | "snacks")
---@field title string Picker window title

local core = require("simple_tasks.core")

local M = {}

---Plugin configuration
---@type SimpleTasksConfig
M.config = {
  picker = "ui", -- ui | snacks
  title = "Project Tasks",
}

---Setup simple_tasks plugin
---
---Example:
---```lua
---require("simple_tasks").setup({
---  picker = "snacks",
---})
---```
---@param opts SimpleTasksConfig|nil
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

---@class SimpleTaskItem
---@field name string Human-readable task name
---@field command string Ex command to execute

---@class SimpleTasksPicker
---@field pick fun(items: SimpleTaskItem[], opts: table)

---Load picker implementation by name
---@param name string
---@return SimpleTasksPicker|nil
local function get_picker(name)
  local ok, picker = pcall(require, "simple_tasks.pickers." .. name)
  if ok then
    return picker
  end
end

---Open task picker and execute selected task
function M.pick()
  local tasks, err = core.read_tasks()
  if not tasks then
    vim.notify(err, vim.log.levels.WARN)
    return
  end

  ---@type SimpleTaskItem[]
  local items = core.normalize(tasks)

  ---@type SimpleTasksPicker
  local picker = get_picker(M.config.picker)
    or get_picker("ui")

  picker.pick(items, {
    title = M.config.title,
  })
end

return M
