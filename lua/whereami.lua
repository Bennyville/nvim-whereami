local parsers = require'nvim-treesitter.parsers'

local whereami = {}

local lang_handlers = {
	php = require'lang.php',
}

function whereami.get_root_dir()
	local git_dir = vim.fn.finddir('.git', '.;')
	local hg_dir = vim.fn.finddir('.hg', '.;')

	local vcs_dir = git_dir ~= "" and git_dir or hg_dir

	local vcs_root

	if vcs_dir == "" then
		vcs_root = vim.fn.getcwd()
	else
		vcs_root = vim.fn.fnamemodify(vcs_dir, ':p:h:h')
	end

	local file_path = vim.fn.expand('%:p')
	local relative_path = string.sub(file_path, #vcs_root+2)

	return relative_path
end

function whereami.copy_reference()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2]

	local lang = parsers.get_buf_lang(bufnr)

	local handler = lang_handlers[lang]

	if not handler or type(handler.handle) ~= 'function' then
		print("Handler for " .. lang .. " not correctly implemented or not available.")
		return
	end

	if not parsers.has_parser(lang) then
		print("Parser for " .. lang .. " is not available.")
		return
	end

	local tree = parsers.get_parser(bufnr, lang):parse()[1]
	local root = tree:root()

	local node = root:named_descendant_for_range(row, col, row, col)

	if not node then
		print("No node found at cursor.")
		return
	end

	local root_dir = whereami.get_root_dir()
	local code_reference = handler.handle(root, node)
	local line_number = row+1

	local reference = root_dir .. ':' .. code_reference .. ':' .. line_number

	vim.fn.setreg('*', reference)

	print("Copied reference: " .. reference)
end

return whereami
