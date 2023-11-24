local separators = {
	default = {
		namespace = { prefix = '', suffix = '.', },
		class = { prefix = '', suffix = '.', },
		method = { prefix = '', suffix = '()', },
		fn = { prefix = '', suffix = '()', },
		property = { prefix = '', suffix = '.', }
	},
	lua = {
		fn = { prefix = '', suffix = '()', },
	},
	typescript = {
		class = { prefix = '', suffix = '', },
		method = { prefix = '.', suffix = '()', },
		fn = { prefix = '', suffix = '()', },
	},
	javascript = {
		class = { prefix = '', suffix = '', },
		method = { prefix = '.', suffix = '()', },
		fn = { prefix = '', suffix = '()', },
	},
	php = {
		namespace = { prefix = '', suffix = '', },
		class = { prefix = '\\', suffix = '', },
		method = { prefix = '::', suffix = '()', },
		property = { prefix = '', suffix = '', },
	},
	rust = {
		fn = { prefix = '', suffix = '()', },
	},
}

return separators
