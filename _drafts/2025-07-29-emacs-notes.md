---
date: 2025-07-29 12:00
title: Emacs Notes
categories: [computing]
tags: [emacs]
---

## Terminology

A *key sequence*, or just a *key*, is a sequence of keyboard actions.

A *complete key* is one or more key sequences that invoke a command.

A sequence of keys which is not a complete key is a *prefix key*.

*C-x* is a prefix key.

*C-x C-f* is a complete key.

In *C-x 8 P* both *C-x* and *8* are prefix keys. The key is complete when *P* is pressed.

### Some Basic Complete Keys

| Key Sequence | Action |
| --- | --- |
| C-x C-f | Find (open) a file |
| C-x C-s | Save the buffer |
| C-x b | Switch buffer |
| C-x k | Kill (close) a buffer |
| C-x C-b | Display all open buffers |
| C-x C-c | Exit Emacs |
| M-x | Execute extended command |
| M-S-x | Execute extended command for buffer* |
| C-g | 'Bail out' |

* The available extendec commands are limited to those relevant to the current buffer.

### Some Basic Window Key Sequences

