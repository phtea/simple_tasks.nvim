local runner = require("simple_tasks.runner")

local M = {}

function M.pick(items, opts)
	vim.ui.select(items, {
		prompt = opts.title or "Project Tasks",
		format_item = function(item)
			return item.name
		end,
	}, function(item)
			if not item then
				return
			end

			runner.run(item)
		end)
end

return M
