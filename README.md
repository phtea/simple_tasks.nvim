# simple_tasks.nvim

A tiny, dependency-free project task runner for Neovim.

`simple_tasks.nvim` reads tasks from a project-local `.tasks.json` file and lets you run them through a picker (`vim.ui.select` by default, or `snacks.nvim` if you want something nicer).

No job managers.
No frameworks.
Just tasks → pick → execute.

---

## ✨ Features

- 📁 Project-local tasks via `.tasks.json`
- 🧠 Zero required dependencies
- 🔌 Pluggable picker strategies
  - `vim.ui.select` (default)
  - `snacks.nvim` (optional)
- ⚡ Executes plain Ex commands
- 🧩 Small, readable codebase

---

## 📦 Installation

Using Neovim’s built-in package manager (0.12+):

```lua
vim.pack.add {
    src = "https://github.com/phtea/simple_tasks.nvim"
}

local st = require("simple_tasks")
st.setup({ picker = "snacks" })

vim.keymap.set("n", "<leader>tt", st.pick, { desc = "Project tasks", })
```
