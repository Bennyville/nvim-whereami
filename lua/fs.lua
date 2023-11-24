local fs = {}

function fs.get_root_dir()
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

return fs
