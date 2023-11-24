# whereami [work in progress]

A neovim plugin that helps to point to a specific place inside your code. Inspired by Intellijs "Copy reference" function. Useful for discussion, feedback, code reviews, and collaboration

**The plugin is still work in progress. It already works in many languages, but for some it will probably not yet produce a good result. I am trying to develop a universal solution for all languages. I love to hear your feedback!**

## Table of contents

  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
      * [Requirements](#requirements)
  - [License](#license)

## Features

- Provides a reference to the exact location of your code.
- Easy to use: just position your cursor anywhere in your code and run the command.
- Works for all languages, someday (work in progress)

## Installation

### Requirements

- neovim
- treesitter (+ language parser)

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

## License

[MIT](LICENSE)

