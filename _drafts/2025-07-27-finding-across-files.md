---
date: 2025-07-27 12:00
title: Finding Across Files
categories: [computing]
tags: [emacs]
---

Yesterday I updated my blog to use a new theme. One thing I missed during the process was how internal links (links between posts) were broken because, to coin a well worn developer prhrase, "It worked find on my computer."

My old template had seemed to handle links between posts that looked like this:

```md
This is [a link to another post](2025-07-26-updating-my-blog) to a page.
```

You are meant to use the [post_url](https://jekyllrb.com/docs/liquid/tags/#linking-to-posts) tag:

{% highlight liquid %}{% include 2025-07-27-finding-across-files-01.html %}{% endhighlight %}

I need to 'wrap' each blog post link within `{% include 2025-07-27-finding-across-files-02.html %}` and `{% include 2025-07-27-finding-across-files-03.html %}` to fix things. I decided to see how it would be done in Emacs.

## Finding The Internal Links

I can search for the end of the link text and the start of the link itself, helped by the fact that all of my posts have been written in the 21st century. This means that I can search for `](20` to find the start of all of the internal links.

`[grep](https://www.gnu.org/software/grep.html)` is a command-line utility that searches for pattern matches with files. `rgrep` is a variant of grep which searches recursively in sub-directories too. Fortunately it is standard on Unix-like operating systems like Linux.

1. Start an rgrep search: `Meta-x rgrep`
2. Search for `](20`.
3. Search for files matching `*.md`
4. Search recursively in the `./blog/` folder

The results are shown in a new buffer.

I had 27 links that I needed to fix.

## Fixing The Links

