---
date: 2025-05-04 12:00
title: VIM Comments
categories: [computing]
tags: [vim]
---

> I am seeing if I can switch to using [Neovim](https://neovim.io/) as my editor of choice, not just for things like blog posts but also as a replacement for [VS Code](https://code.visualstudio.com/) for development work. This is one of a set of posts to help me remember things I configure or learn. They are grouped in the [vim category](/categories/#vim).

## Treesitter

The [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin adds programming language support to Neovim. This essentially means that it can parse various file types (Markdown, Lua, Elixir, HTML, C, etc.) and provide syntax highlighting and other features such as knowing the commenting styles.

I've added the plugin and language parsers for the file types I tend to use (rather than installing all of the available ones).

There is no manual configuration done beyond this.

## Italicise Comments

This is a cosmetic change which just makes comments visibly different to code by italicising them.

In `init.lua`:

```lua
vim.cmd[[highlight Comment cterm=italic gui=italic]]
```

## (Un)Commenting Lines

I'm using a plugin called [Comment.nvim](https://github.com/numToStr/Comment.nvim) which supports, amongst other things, block comments as well as per-line comments. As far as I can tell, the default Neovim implementation of comments just supports per-line comments so if you have a block of multiple lines which need to be commented out each would be done individually.

In Normal mode, `gcc` toggles the current line using linewise comments. `gbc` toggles the current line using blockwise comments.

In Visual mode, `gc` toggles the region using linewise comments and `gb` toggles the region using blockwise comments.

## Re-Wrapping Comments

In VS Code I use a plugin called [Rewrap](https://github.com/stkb/Rewrap) to re-wrap comments. It allows you to write comments in a long, single line of text and then re-wrap them to be on multiple lines, with no single line exceeding a pre-defined limit.

In Neovim this is built-in and you can use the `gqq` command in Normal mode and `gq` command in Visual mode.

