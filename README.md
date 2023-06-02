# whereami

A neovim plugin that helps to point to a specific place inside your code. Useful for discussion, feedback, code reviews, and collaboration.

## Features

- Provides a reference to the exact location of your code.
- Easy to use: just position your cursor on a method and run the command.
- Supported languages*: PHP.

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

This will copy a reference to your clipboard in a language specific format*, useful for pinpointing specific sections of code for discussion, feedback, or review.

## Requirements

- neovim
- treesitter

## Contributing

Contributions are welcome! Please see [here](CONTRIBUTING.md) for details.

## License

[MIT](LICENSE)

\* Whereami will just copy the line number in the current file.
