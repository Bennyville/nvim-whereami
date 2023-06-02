local ts_utils = require'nvim-treesitter.ts_utils'

local php = {}

function php.handle(root, node)
	local method_name, property_name, class_name, namespace_name

	while node do
		local node_type = node:type()

		if node_type == 'method_declaration' then
			for _, child in ipairs(ts_utils.get_named_children(node)) do
				if child:type() == 'name' then
					method_name = ts_utils.get_node_text(child)[1]
					break
				end
			end
		elseif node_type == 'property_declaration' then
			print(node_type)
			for _, child in ipairs(ts_utils.get_named_children(node)) do
				print(child:type())
				if child:type() == 'property_element' then
					property_name = ts_utils.get_node_text(child)[1]
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

	local reference = ''

	if namespace_name then
		reference = reference .. namespace_name .. '\\'
	end

	if class_name then
		reference = reference .. class_name .. '::'
	end

	if method_name then
		reference = reference .. method_name .. '()'
	elseif property_name then
		reference = reference .. property_name
	end

	return reference
end

return php
