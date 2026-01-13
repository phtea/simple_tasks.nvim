local M = {}

local uv = vim.uv or vim.loop

function M.find_tasks_file()
  local root = vim.fs.root(0, {
    ".git",
    "Makefile",
    "CMakeLists.txt",
    ".tasks.json",
  })

  if not root then
    return nil
  end

  local path = root .. "/.tasks.json"
  if uv.fs_stat(path) then
    return path
  end

  return nil
end

function M.read_tasks()
  local path = M.find_tasks_file()
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
