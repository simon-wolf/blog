---
date: 2025-05-02 12:00
title: Vim Buffers, Windows, and Tabs
categories: [computing]
tags: [vim]
---

Most of the time I use Vim it is in a very basic way... I open a file (or create a new one) from a terminal prompt, edit it, and then close Vim. If I need to edit another file I'll open it from the terminal and so on. I'm not staying in Vim and working with different files and it has taken me a little while to get my head around this.

These notes are to help me remember the various bits and pieces.

## Buffers

When a file is opened in Vim it is held in a buffer. It is viewed through a viewport (aka a window).

If another file is opened then it is held another buffer.

### File Open And Saving Refresher

If Vim is already running, a new buffer can be created via `:enew`.

I can load and show a file's buffer in the current window via `:e <filename>` or `:edit <filename>`.

I can use `:Ex` or `:e .` to open a file browser and select a file to open.

I can use `:Ex <directory>` or `:e <directory>` to open a file browser starting in the specified directory.

If I want to open more than one file then I can use `:n <file1> <file2>`.

Once I have finished editing the file can be saved via `:w`.

To save the current buffer to a different file use `:w <filename>`. This will not create a buffer for the new file and the original file's buffer will still have any unsaved changes.

To save the edits to a different file and show that file's buffer use `sav <filename>`. This will show the new file's buffer in the current window and leave the original file's buffer, including unsaved changes, open.

I can view the working directory with `:pwd`.

### Listing Buffers

I can list the buffers via `:buffers` or `:ls`. As well as showing the buffer number, the list shows some information about each buffer via a combination of indicators and flags. Then the file path and the cursor line number are shown.

Some common indicators and flags are:

| Indicators | Meaning |
| --- | --- |
| `%` | Buffer is in the current window |
| `a` | Active buffer - loaded and visible |
| `h` | Hidden |
| `+` | Modified |
| `=` | Readonly |

### Managing Buffers

I can switch to a different buffer via `:buffer [n]` or `:b [n]` where `n` is the buffer number shown from the list.

I can remove a buffer using `:bd [n]`.

`:bprevious` or `:bprev` and `:bnext` allows me to cycle through the buffers.

`:e #` allows me to switch to the last buffer.

`:b [name]` allows me to switch to a buffer using its file name (any part of it). Typing `:b [name]<Tab>` allows me to see a list of natching buffers and jump to them.

I can open a file's buffer without showing it in a window with `:badd ...`.

### The Statusline

In Vim, if I enter insert mode I am no longer shown the file name. After coming out of it I need to type `<Ctrl-g>`.

In Vim and Neovim, to show the buffer number I are currently viewing/editing I can use `2 <Ctrl-g>`.

To make things even easier I use the [lualine](https://github.com/nvim-lualine/lualine.nvim) plugin.

## Viewports/Windows

View Ports or Windows allow me to see more than one buffer at a time. Or the same buffer in more than one window.

### Creating New Windows

`:sp`, `:split` or `<Ctrl-w> n` will split the screen to show two windows horizontally. They will show the same buffer.

`:sp [FILENAME]` will split the screen and load [FILENAME] into the top window. Each window has its own buffer.

`:vsp` or `:vsplit` will split the screen vertically. Again, a file can be loaded into the new window.

To load a buffer into a new window use `:sbuffer n` where n is the buffer number. For a vertical split use `:vert sbuffer n`.

To create a new, empty, buffer in a new window, use `:new` or `:vert new`.

### Moving Between Windows

`<Ctrl-w><Down>` will move the focus to the lower window.`<Ctrl-w><Up>` will move the focus to the upper window. Left and right movements are achieved in the same way.

### Resizing Windows

`<Ctrl-w>+` increases the size of the current window by one line. `<Ctrl-w>-` decreases it by one line.

`<Ctrl-w>n+` increases it by n lines. `<Ctrl-w>n-` decreases it by n lines.

For vertical splits use `<Ctrl-w><` and `<Ctrl-w>>`. Again numbers can be prepended.

`<Ctrl-w>=` sizes all windows equally.

`<Ctrl-w>r` swaps the position of the windows but only a pair of horizontal or vertical ones.

### Closing Windows

To close a window either type `:close` or use `<Ctrl-w>c`.

If a window containing a modified buffer is closed (`:close!`) then the window is hidden but the buffer remains in memory so it can be switched to, saved, further edited, etc.

To close all windows and quit Vim, run `:quitall`.

To close all but the active window, use `<Ctrl-w>o` or `:only`.

## Tabs



## Fuzzy Finding Files

One of the things I do most frquently in VS Code (other than editing text) is moving between files in my code projects. Sometimes this involves the file tree (covered in a different post) but I generally do this via the `<Ctrl-P>` shortcut to perform a filename search.

In Vim I'm using a plugin to provide this functionality.


