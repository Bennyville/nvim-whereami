local nodes = {};

nodes.namespace_nodes = {
	namespace_declaration = 'namespace',
	namespace_definition = 'namespace',
	package_declaration = 'package',
	package_definition = 'package',
}

nodes.reference_nodes = {
	class_declaration = 'class',
	class_definition = 'class',
	module_declaration = 'module',
	module_definition = 'module',
	function_declaration = 'fn',
	function_definition = 'fn',
	function_item = 'fn',
	method_declaration = 'method',
	method_definition = 'method',
	property_declaration = 'property',
	property_definition = 'property',
}

nodes.name_nodes = {
	name = 'name',
	identifier = 'name',
	dot_index_expression = 'name',
	property_element = 'name',
	property_identifier = 'name',
	namespace_name = 'name',
	word = 'name',
}

return nodes
