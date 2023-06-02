local ts_utils = require'nvim-treesitter.ts_utils'

local php = {}

function php.handle(root, node)
	local method_name, class_name, namespace_name

	while node do
		local node_type = node:type()

		if node_type == 'method_declaration' then
			for _, child in ipairs(ts_utils.get_named_children(node)) do
				if child:type() == 'name' then
					method_name = ts_utils.get_node_text(child)[1]
					break
				end
			end
		elseif node_type == 'class_declaration' then
			for _, child in ipairs(ts_utils.get_named_children(node)) do
				if child:type() == 'name' then
					class_name = ts_utils.get_node_text(child)[1]
					break
				end
			end
		end

		node = node:parent()
	end

	if not method_name then
		print("Cursor is not positioned on a method.")
		return
	end

	if not class_name then
		print("Cursor is not positioned inside a class.")
		return
	end

	for _, node in ipairs(ts_utils.get_named_children(root)) do
		if node:type() == 'namespace_definition' then
			for _, child in ipairs(ts_utils.get_named_children(node)) do
				if child:type() == 'namespace_name' then
					namespace_name = ts_utils.get_node_text(child)[1]
					break
				end
			end
			break
		end
	end

	if not namespace_name then
		print("No namespace found in file.")
		return
	end

	local reference = namespace_name .. '\\' .. class_name .. '::' .. method_name .. '()'

	return reference
end

return php
