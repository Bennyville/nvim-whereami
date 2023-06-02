# whereami

A neovim plugin that helps to point to a specific place inside your code. Inspired by Intellijs "Copy reference" function. Useful for discussion, feedback, code reviews, and collaboration.

## Table of contents

  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Requirements](#requirements)
  - [Contributing](#contributing)
  - [License](#license)

## Features

- Provides a reference to the exact location of your code.
- Easy to use: just position your cursor anywhere in your code and run the command.
- Supported languages: PHP. (uses <file_path>:<line_number> in unsupported languages)

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug):

```lua
Plug 'bennyville/whereami'
```

### Using [Vundle](https://github.com/VundleVim/Vundle.vim):

```lua
Plugin 'bennyville/whereami'
```

### Using [Packer](https://github.com/wbthomason/packer.nvim):

```lua
use { 'bennyville/whereami' }
```

## Usage

Position your cursor anywhere in your code and run:

```lua
:Whereami
```

or create a mapping

```lua
vim.keymap.set('n', '<leader>cr', ':Whereami<CR>')
```

This will copy a reference to your clipboard in a language specific format, useful for pinpointing specific sections of code for discussion, feedback, or review.

## Requirements

- neovim
- treesitter

## Contributing

Contributions are welcome! Please see [here](CONTRIBUTING.md) for details.

## License

[MIT](LICENSE)

