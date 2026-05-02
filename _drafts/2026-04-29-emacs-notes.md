---
date: 2026-04-29 12:00
title: Emacs Notes
categories: [computing]
tags: [emacs]
---

This post is my set of notes about using Emacs and it will evolve over time as I work out how to do new things. The notes will be very personal to me and my use of Emacs but they might be handy for other people so I thought I would make it a public post, albeit one which will evolve over time.

The main things this post will conver are:

* General notes about using Emacs, terminology, etc.
* Notes about the Emacs equivalents to things I do in Neovim, VS Code, etc.
* Reminders to myself about things I want to dig into.

## Some Basic Key Sequences

| Key Sequence | Action |
| --- | --- |
| C-x C-c | Exit Emacs |
| M-x | Execute extended command |
| C-g | 'Bail out' |
| Esc Esc Esc | Quit out of prompts, regions, prefix arguments |

## Buffers, Windows, Frames, and Tabs

A buffer displays content. Everything you see and type is in a buffer.

A window is a view of the contents of a buffer. A window displays the contents of one buffer (but you can display the same buffer in multiple windows).

Windows are displayed in a frame. A frame can display one or more windows.

The cursor is only ever in one window and that is called the selected window or current window.

At the bottom of each window is the mode line and below that is the echo area.

### Buffers

| Key Sequence | Action |
| --- | --- |
| C-x C-f | Find (open) a file |
| C-x C-s | Save the buffer |
| C-x b | Switch buffer |
| C-x k | Kill (close) a buffer |
| C-x C-b | Display all open buffers |
| M-S-x | Execute extended command relevant for buffer |

### Windows

| Key Sequence | Action |
| --- | --- |
| C-x 0 | Delete the active window |
| C-x 1 | Delete other windows |
| C-x 2 | Split window below |
| C-x 3 | Split window right |
| C-x o | Switch active window |

To make switching windows easier, rebind `C-x o` to `M-o`:

```
(global-set-key (kbd "M-o") 'other-window)
```

To do something like opening a file in a new window you don't need to split the current window (which will show the same buffer in both, switch to the other window and then open the file. You can act on other windows instead.

Note that if there is already another window, that will be used. These commands only create a new window if there is currently only one.

| Key Sequence | Action |
| --- | --- |
| C-x 4 C-f | Find a file in the other window |
| C-x 4 d | Open Dired in the other window |
| C-x 4 C-o | Display a buffer in the other window |
| C-x 4 b | Switch the buffer in the other window and make it the active window |

To have the split be horizontally (`[]|[]`) by default:

```
(setq split-width-threshold 1)
```

**To-Do:** Investigate `winner-mode`.

### Frames

Managing frames is very similar to managing windows:

| Key Sequence | Action |
| --- | --- |
| C-x 5 0 | Delete the active frame |
| C-x 5 1 | Delete the other frame |
| C-x 5 2 | Create a new frame (follows the standard split rules) |
| C-x 5 C-f | Find a file in the other frame |
| C-x 5 d | Open Dired in the other frame |
| C-x 5 C-o | Display a buffer in the other frame |
| C-x 5 b | Switch the buffer in the other frame and make it the active window |

**Note:** Frames all share the same Emacs session so whilst they look like different instances of Emacs they are not. They are good for multi-monitor setups however.

**To-Do:** Investigate [`transpose-frame`](https://github.com/emacsorphanage/transpose-frame) package to swap frames around.

### Tab Line Mode

By default tab line mode shows tabs for buffers previously opened in a window.

It can be enabled with `M-x global-tab-line-mode`.

| Key Sequence | Action |
| --- | --- |
| C-x <left> | Select previous buffer |
| C-x <right> | Select next buffer |

This is not enormously useful.

### Tab Bar Mode

Tab bar mode essentially manages multiple windows in a tabbed layout rather than in a tiled layout.

This is very similar to how VS Code has tabs for files.

It can be invoked via `M-x tab-bar-mode` or by invoking one of the key bindings below:

| Key Sequence | Action |
| --- | --- |
| C-x t 0 | Close the current tab |
| C-x t 1 | Close all other tabs |
| C-x t 2 | Create a new tab |
| C-x t RET | Select tab by name |
| C-x t o, C-\<tab\> | Next tab |
| C-S-\<tab\> | Previous tab |
| C-x t r | Rename tab |
| C-x t d | Open Dired in other tab |
| C-x t C-f | Find file in other tab |
| C-x t b | Switch to buffer in other tab |
| M-x tab-list | Shows an interactive tab list |
| M-x tab-undo | Undoes a closed tab |
| M-x tab-recent | Switches to the last visited tab |

**To-Do:** Play with `tab-bar-history-...`

## General Editing Notes

### Cut, Copy, and Paste

The Emacs terminology is:

* Cutting -> Killing
* Copying -> Saving to the kill ring
* Pasting -> Yanking

...

### Undo and Redo

...

### Marking and Bookmarks

...

### Neovim `dd`

Emacs has `C-k` (`kill-line`) which deletes from the cursor to the end of the line. To delete the whole line use `C-a C-k`. But that just removed the 'contents' and leaves an empty line so maybe use `M-x kill-whole-line`.

### Multiple Cursors

Add the [`multiple-cursors`](https://github.com/magnars/multiple-cursors.el) package.


## Quality of Life Improvements

### Improving The Completions Buffer

```
;; Improve *Completions* buffer behaviour
(setq completion-auto-help 'always)
(setq completion-auto-select 'second-tab)
```

From [Robert Enzmann's blog](https://robbmann.io/posts/emacs-29-completions/)

## Project.el

`C-x p d` to launch Dired in the root of the project's folder.

`C-x p b` to switch buffer but only to ones in the current project.

`C-x p f` to find files in the project. This is an equivalent of VS Code's `Ctrl+p`. To extend the search to files outside of the project use `C-x p F`.

`C-x p g` to to find in files in the project. This is an equivalent of VS Code's `Ctrl+Shift+f`. To extend the search to files outside of the project use `C-x p G`.

## Magit

`C-x g` to launch Magit.

`Tab` to open and close sections.

`F` to pull changes.

`s` stages a file.

`c c` initiates a commit. `C-c C-c` creates the commit.

`P u` pushes upstream.

`k` (`magit-discard-item`) discards changes in a file.

`q` closes the Magic buffer.

`g` refreshes the buffer.
