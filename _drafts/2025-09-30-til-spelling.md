---
date: 2025-09-30 12:00
title: Emacs Notes - Spelling
categories: [computing]
tags: [emacs]
---

These are my part of my personal notes which act as reminders about how to do things in Emacs. They are not a comprehensive reference of exhaustive guide, they simply reflect the functionality I will use at various points in time.

### Background

The current spelling 'engine' is [GNU Aspell](https://en.wikipedia.org/wiki/GNU_Aspell) which is its own application rather than being part of Emacs itself.

> Previously Emacs had used [Ispell](https://en.wikipedia.org/wiki/Ispell) which is why many of the commands are `ispell-...`.

In addition to Aspell, Emacs has flyspell, a minor mode, which highlights spelling errors as you type.

### Keys and Commands

| Keystrokes | Command Word | Action |
| ---------- | ------------ | ------ |
| (none) | ispell-buffer | Runs a spell check on the entire buffer. |
| (none) | ispell-region | Runs a spell check on a region. |
| `M-$` | ispell-word | Checks the word at the point. |
| (none) | flyspell-mode | A minor mode that highlights spelling errors. |
| (none) | flyspell-prog-mode | A minor mode for developers that only highlights spelling errors in comments and strings. |
