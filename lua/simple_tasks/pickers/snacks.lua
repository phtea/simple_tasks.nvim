local M = {}

function M.pick(items, opts)
	require("snacks.picker").pick({
		title = opts.title or "Project Tasks",

		items = items,
		format = function(item)
			return {
				{ "󱁤 ", "Comment" },
				{ item.name, "Normal" },
			}
		end,

		confirm = function(picker, item)
			picker:close()
			vim.notify("Running: " .. item.name)
			vim.cmd(item.command)
		end,
	})
end

return M
