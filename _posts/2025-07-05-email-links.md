---
date: 2025-07-05 12:00
title: Email Links
categories: [computing]
tags: [productivity, email, linux, vim]
---

Like most people I struggle to manage emails. One of my bigger issues is that if I need to follow-up on an email or refer back to it I tend to leave it marked as unread or I occasionally flag it. However that gives me no context at all about the tasks involved or why I might need to refer to it and no ability to say when it needs to be dealt with. I know that there are services and some email clients which allow you to kind of manage this but I use Thunderbird on Linux when I'm at my desk and I'm not prepared to give a third-party service access to all of my emails.

But I think I've finally fixed the problem and devised a way to handle things in a much better way and, whilst this is all very specific to my own setup and workflows, I thought it was still worth sharing.

## Message-Id

All emails contain a header called [Message-Id](https://en.wikipedia.org/wiki/Message-ID). This is a unique identifier which is assigned by the client application that sends the email or the first mail server to receive it.

I use Thunderbird as my main email client and there is an add-on called [Copy Message ID](https://github.com/garoose/copy-message-id) which allows you to click a button and copy the Message-Id onto the clipboard. I have configured it to add a prefix of `mid:` too.

Within Thunderbird I can search for messages and I can customise how it works so it's easy to add the "Message-Id" as an email header to search against. This makes it simple to find messages by their ID but it is also a bit manual and clunky.

## Open In Thunderbird...

Thunderbird can be launched from the command-line and you can pass it a string with the prefix `mid:` and a Message-Id and Thunderbird will open the message for you.

`thunderbird "mid:010201ff6..."`

(this is why I have Copy Message ID add the `mid:` prefix)

This can be made even more convenient by having my computer treat `mid:` as a custom URI so that I can create a link which will call the same command.

This is achieved by creating a custom URI handler via [`xdg`](https://www.freedesktop.org/wiki/Software/xdg-utils/).

For me this is a NixOS Home-Manager configuration change:

```text
xdg.mimeApps.defaultApplications = {
  "x-scheme-handler/mid" = "thunderbird.desktop";
};
```

This means that if I have a link on a web page which pointed to `thunderbird "mid:010201ff6..."` I could click on it and that email would be opened in Thunderbird.

## Putting It All Together

I use text files to maintain a work log. These are simply a Markdown file for each month and I list things I need to do or remember in them.

A very basic example would be:

```text
# July 2025

## 2025-07-05

- [ ] Write up notes about email management.
- [x] Send overdue invoice reminder to Acme Inc.
- [x] Order more paperclips.

## 2025-07-06

- [x] Fix my buggy code.
- [ ] Reply to John's email about the contract changes.
...
```

The last item on the list would usually be accompanied by an unread email sitting in my inbox which I would need to find and then reply to at some point in the future.

Now however I can add links to my emails in those notes:

```text
## 2025-07-06

- [x] Fix my buggy code.
- [ ] Reply to [John's email](mid:dfc8c...) about the contract changes.
...
```

John's email can be marked as read and filed in an appropriate folder and I don't need to worry about it again. When I have done whatever work I need to do in order to complete this task I can just use the link to jump straight to the email and reply to it.

## Neovim

I use Neovim for editing my notes and I have it configured so that markdown files have their [`conceallevel`](https://neovim.io/doc/user/options.html#'conceallevel') set to 2 so that the link URLs are hidden unless the line has the cursor on it. That takes care of keeping my notes easily readable.

Neovim can open links when you press `g` and then `x` and because `mid:` is recognised as a URI on my computer Neovim can open my Message-Id links.

You need to have the cursor somewhere within the link text for this to work and I am lazy so I have defined a keymap which saves me from worrying about where the cursor is:

```lua
vim.keymap.set("n", "<leader>gx", function()
    vim.api.nvim_feedkeys("0f(gx", "t", false)
end, { silent = tue, desc = "Open first link in line" })
```

Now, when I press the `leader` key and then `g` and then `x` the cursor moves to the start of the line, finds the first opening bracket and then 'presses' `g` and `x` for me. Essentially I can be anywhere on the line and the first link will be opened.

And now, at last, I have a simple way to refer back to emails and more easily integrate them into my daily workflows. And if I move on from Thunderbird or stop using Neovim it is all customisable enough that I am not locked into anything in any way.
