local parsers = require 'nvim-treesitter.parsers'
local fs = require 'fs'
local separators = require 'separators'
local nodes = require 'nodes'

local whereami = {}

local function get_cursor_pos()
	local cursor = vim.api.nvim_win_get_cursor(0)

	return cursor[1] - 1, cursor[2]
end

local function build_reference(code_reference, lang_separators, line_number)
	local reference = ''

	local reference_order = {
		'namespace',
		'package',
		'class',
		'module',
		'fn',
		'method',
		'property'
	}

	for _, node_type in ipairs(reference_order) do
		if code_reference[node_type] ~= nil then
			if lang_separators[node_type] ~= nil then
				reference = reference ..
					lang_separators[node_type].prefix .. code_reference[node_type] .. lang_separators[node_type].suffix
			else
				reference = reference .. code_reference[node_type]
			end
		end
	end

	local has_namespace = false

	for _, value in pairs(nodes.namespace_nodes) do
		if code_reference[value] ~= nil then
			has_namespace = true
		end
	end

	if has_namespace == false then
		local path = fs.get_root_dir()

		if path ~= nil then
			reference = path .. ':' .. reference
		end
	end

	return reference .. ':' .. line_number
end

local function find_namespace_nodes(root)
	local namespace_nodes = {}

	for child, _ in root:iter_children() do
		local node_type = child:type()

		if nodes.namespace_nodes[node_type] ~= nil then
			local namespace_node_type = nodes.namespace_nodes[node_type]
			namespace_nodes[namespace_node_type] = child
		end
	end

	return namespace_nodes
end

local function find_named_node(node)
	for child, _ in node:iter_children() do
		local child_type = child:type()

		if child:named() and nodes.name_nodes[child_type] ~= nil then
			return child
		end
	end
end

local function find_reference_nodes(current_node)
	local reference_nodes = {}

	while current_node do
		local current_node_type = current_node:type()

		if nodes.reference_nodes[current_node_type] ~= nil then
			local reference_node_type = nodes.reference_nodes[current_node_type]

			reference_nodes[reference_node_type] = current_node
		end

		current_node = current_node:parent()
	end

	return reference_nodes
end

local function safe_treesitter_parse(bufnr, lang)
    if not parsers.has_parser(lang) then
        error("No Treesitter parser available for current buffer's language: " .. lang)
    end

    local parser = parsers.get_parser(bufnr, lang)

    local tree = parser:parse()

    if not tree or #tree == 0 then
        error("Failed to parse buffer with Treesitter. Language: " .. lang)
    end

    return tree[1]
end

local function get_reference()
	local bufnr = vim.api.nvim_get_current_buf()
    local lang = parsers.get_buf_lang(bufnr)

    local tree = safe_treesitter_parse(bufnr, lang)
    local root = tree:root()

	local row, col = get_cursor_pos()

	local current_node = root:named_descendant_for_range(row, col, row, col)

	local code_reference = {}

	local reference_nodes = find_reference_nodes(current_node)

	for reference_node_type, reference_node in pairs(reference_nodes) do
		if code_reference[reference_node_type] == nil then
			local named_node = find_named_node(reference_node)
			code_reference[reference_node_type] = vim.treesitter.get_node_text(named_node, 0)
		end
	end

	local namespace_nodes = find_namespace_nodes(root)

	for namespace_node_type, namespace_node in pairs(namespace_nodes) do
		if code_reference[namespace_node_type] == nil then
			local named_node = find_named_node(namespace_node)
			code_reference[namespace_node_type] = vim.treesitter.get_node_text(named_node, 0)
		end
	end

	if separators[lang] == nil then
		lang = 'default'
	end

	return build_reference(code_reference, separators[lang], row + 1)
end

function whereami.copy_reference()
	local success, reference = pcall(get_reference)

    if not success then
        vim.api.nvim_err_writeln("Error getting reference: " .. reference)
        return
    end

	vim.fn.setreg('*', reference)

	print("Copied reference: " .. reference)
end

return whereami
