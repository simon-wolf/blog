---
date: 2025-04-27 15:56
title: Vim Buffers, Windows, and Tabs
categories: linux
---

Most of the time I use Vim it is in a very basic way... I open a file (or create a new one) in Vim, edit it, and then close Vim. If I need to edit another file I'll open it in Vim and so on. I'm not staying in Vim and working with different files and it has taken me a little while to get my head around this.

These notes are to help me remember the various bits and pieces.

## Buffers

When a file is opened in Vim it is held in a buffer. You view it through a view port (aka a window).

If you open another file (`edit ...` or `:e ...`) then it is opened in another buffer. You can name it relative to the current working directory or specify the full path. If you start typing the name and press `<Tab>` then you can see a list of matching files and select one. 

You can view your working directory with `:pwd`.

You can list the buffers via `:buffers` or `:ls`. As well as showing the buffer number, the list shows some information about each buffer via a combination of indicators and flags. Then the file path and the cursor line number are shown.

Some common indicators and flags are:

| Indicators | Meaning |
| --- | --- |
| `%` | Buffer is in the current window |
| `a` | Active buffer - loaded and visible |
| `h` | Hidden |
| `+` | Modified |
| `=` | Readonly |

You can switch to a different buffer via `:buffer [n]` or `:b [n]` where `n` is the buffer number shown from the list.

You can remove a buffer using `:bd [n]`.

`:bprevious` or `:bprev` and `:bnext` allows you to cycle through the buffers.

`:e #` allows you to switch to the last buffer.

`:b [name]` allows you to switch to a buffer using its file name (any part of it).

Typing `:b [name]<Tab>` allows you to see a list of natching buffers and jump to them.

You can add a file to a buffer without opening it with `:badd ...`.

### The Statusline

In Vim, if you enter insert mode you are no longer shown the file name. After coming out of it you need to type `<Ctrl-g>`.

In Vim and Neovim, to show the buffer number you are currently viewing/editing you can use `2 <Ctrl-g>`.


## View Ports/Windows

View Ports or Windows allow you to see more than one buffer at a time. Or the same buffer in more than one window.

### Creating New Windows

`:split` will split the screen to show two windows horizontally. They will show the same buffer.

`:split [FILENAME]` will split the screen and load [FILENAME] into the top window. Each window has its own buffer.

`:vertical split` or `:vsplit` will split the screen vertically. Again, a file can be loaded into the new window.

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

If you close a window containing a modified buffer (`:close!`) then the window is hidden but the buffer remains in memory so it can be switched to, saved, further edited, etc.

To close all windows and quit Vim, run `:quitall`.

To close all but the active window, use `<Ctrl-w>o` or `:only`.

## Tabs



## Fuzzy Finding Files

One of the things I do most frquently in VS Code (other than editing text) is moving between files in my code projects. Sometimes this involves the file tree (covered in a different post) but I generally do this via the `<Ctrl-P>` shortcut to perform a filename search.

In Vim I'm using a plugin to provide this functionality.


