local M = {}

local uv = vim.uv or vim.loop

---@param fallback_paths string[]|nil
---@return string|nil
function M.find_tasks_file(fallback_paths)
  -- 1. project-local
  local root = vim.fs.root(0, {
    ".git",
    "Makefile",
    "CMakeLists.txt",
    ".tasks.json",
  })

  if root then
    local local_path = root .. "/.tasks.json"
    if uv.fs_stat(local_path) then
      return local_path
    end
  end

  -- 2. global fallbacks
  if fallback_paths then
    for _, path in ipairs(fallback_paths) do
      local expanded = vim.fn.expand(path)
      if uv.fs_stat(expanded) then
        return expanded
      end
    end
  end

  return nil
end

---@param fallback_paths string[]|nil
---@return table|nil, string|nil
function M.read_tasks(fallback_paths)
  local path = M.find_tasks_file(fallback_paths)
  if not path then
    return nil, "No .tasks.json found"
  end

  local lines = vim.fn.readfile(path)
  local ok, data = pcall(vim.json.decode, table.concat(lines, "\n"))

  if not ok or type(data) ~= "table" then
    return nil, "Invalid .tasks.json"
  end

  return data
end

---@param tasks table
---@return { name: string, command: string }[]
function M.normalize(tasks)
  local items = {}

  for name, cmd in pairs(tasks) do
    table.insert(items, {
      name = name,
      command = cmd,
    })
  end

  table.sort(items, function(a, b)
    return a.name < b.name
  end)

  return items
end

return M
