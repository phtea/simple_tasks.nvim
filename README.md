# simple_tasks.nvim

A tiny, dependency-free project task runner for Neovim.

`simple_tasks.nvim` reads tasks from a project-local `.tasks.json` file and lets you run them through a picker (`vim.ui.select` by default, or `snacks.nvim` if you want something nicer).

No job managers.
No frameworks.
Just tasks → pick → execute.

---

## ✨ Features

- 📁 Project-local `.tasks.json`
- 🌍 Global `.tasks.json` fallback
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
    { src = "https://github.com/phtea/simple_tasks.nvim" },
}

local st = require("simple_tasks")

-- These are default settings, no need to explicitly set them
st.setup({
    picker = "ui", -- ui | snacks
    title = "Project Tasks",
    fallback_files = {
        "~/.tasks.json",
    },
})

vim.keymap.set("n", "<leader>tt", st.pick, { desc = "Project tasks", })
```

## 📝 `.tasks.json` format

Tasks are defined in a `.tasks.json` file located in your project root  
(or in a global fallback file if no local one exists).

Each task is a key–value pair where:

- **keys** are task names shown in the picker
- **values** are either:
  - a single Ex command (`string`)
  - a list of Ex commands (`string[]`) executed in order

---

### Example

Use a string value for simple, one-step tasks or array of strings for sequencial execution:

```json
{
    "Run tests": "!make test",
    "Format current file": "lua vim.lsp.buf.format()",
    "Format neovim config": [
        "args ~/dotfiles/nvim/.config/nvim/**/*.lua",
        "argdo lua vim.lsp.buf.format()",
        "wa"
    ]
}
```

## 🤝 Contributing

Contributions are very welcome.

If you’d like to:
- improve documentation
- clean up or refactor the code
- add new picker implementations
- fix bugs or edge cases

feel free to open an issue or a pull request.

This plugin is intentionally small and simple, so changes are easy to review.  
I’m happy to review PRs and merge them if they fit the project’s direction and keep the codebase clean.

No strict rules — just keep things minimal and well-reasoned 🙂
