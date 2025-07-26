---
date: 2022-05-22 12:00
title: My Linux Life
categories: [computing]
tags: [linux]
---

## Introduction

After I wrote about my love of [StarLabs's](https://starlabs.systems) 11" laptop, [the StarLite](https://starlabs.systems/pages/starlite), someone asked me about the software I run on it, how I work with people who use Windows and macOS and whether things like using a laptop with 8GB of RAM is a problem. It all seems like good content for a follow-up on my original posts about switching to Linux from [January 2020]({% post_url 2020-01-19-the-year-of-linux-on-my-desktop %}) and [the follow-up]({% post_url 2020-02-19-the-month-of-linux-on-my-desktop %}) I wrote the following month.

As I mentioned yesterday, my laptop is a StarLite and my main work machine is, as per my blog post from February 2020, still the Hades Canyon NUC.

## Software

__Operating Systems__

On my desktop computer I'm still using [Ubuntu](https://ubuntu.com/) 20.04. I'm currently undecided if I will simply update to 22.04 or move over to [Fedora](https://getfedora.org/) or [NixOS](https://nixos.org/).

My 2nd generation StarLite has been used to try out various flavours of Linux and to try window managers instead of desktop environments [explanation](https://www.linuxfordevices.com/tutorials/linux/desktop-environment-vs-window-manager). It currently has NixOS installed on it and I will be carrying on playing with it and seeing if I can get comfortable enough to switch to it on my desktop or not. I need to learn more about NixOS packages before I can get an up-to-date version of [Meteor](https://www.meteor.com/) installed properly for example.

My 4th generation StarLite will be set up with Fedora. This will allow me to install everything I need to work with easily so that my NixOS journey doesn't hold things back.

All three computers use the [GNOME](https://www.gnome.org/) desktop but as part of my NixOS tinkering I will be playing with window managers again. This is mainly because I really like keyboard-driven environments but they are also less resource intensive than a full desktop environment so would be an added bonus on my StarLite.

__Software Development__

Until mid-April I'd spent three years working at [Sketch](https://www.sketch.com/) as a backend developer but I am now self-employed again and working in the family business that my sister and I co-own, [Mindme](https://mindme.care/). I'm still focusing on writing [Elixir](https://elixir-lang.org/) code along with some [Python](https://www.python.org/) so the only major change to my development requirements has been not needing Docker any more.

I use [VSCode](https://code.visualstudio.com/) as my code editor and even when I was still using macOS I would use VS Code for Python development. It's a great IDE and is very versatile and has some incredibly useful plugins.

I'm a bit of a Git klutz so don't just rely on using it from the command line. For the last couple of years I have been using [GitKraken](https://www.gitkraken.com/) which is great but it contains more and more features I don't need. I've been trying [LazyGit](https://github.com/jesseduffield/lazygit) as a possible alternative and it is really good but I'm not comfortable enough to switch to it entirely yet.

For managing programming languages I use [asdf](https://asdf-vm.com/) and the only time I might use something else in the foreseeable future is NixOS's [nix-shell](https://nixos.wiki/wiki/Development_environment_with_nix-shell) feature which allows you to define and run fully containerised development environments meaning that you can run specific versions of Python or Elixir or a database server for each project you are working on. In very simple terms it could be thought of as an alternative to Docker.

Other development tools I use or am trying include:

* [Insomnia](https://insomnia.rest/) as an API client.
* [Beekeeper Studio](https://www.beekeeperstudio.io/) as a SQL client.

__Office & Admin__

[LibraOffice](https://www.libreoffice.org/) is my go-to replacement for Word/Pages, Excel/Numbers and PowerPoint/Keynote. It seems to handle opening and editing Microsoft Office documents without much drama and can save documents in the [OpenDocument Format](https://opendocumentformat.org/) or as MS Office files.

I use [Thunderbird](https://www.thunderbird.net/en-GB/) for emails, contacts and calendar and I use [FastMail](https://www.fastmail.com/) as the provider/host for all three after giving up on iCloud for contact and calendar management after a second occurrence of having things duplicated. The native iOS Mail, Calendar and Contacts apps can all connect to third-party services so this is not a problem.

I use [Firefox](https://www.mozilla.org/en-GB/firefox/) as my web browser and I also use it on my iOS devices with synchronisation enabled between them all. 

I use [Markdown](https://daringfireball.net/projects/markdown/) a lot for writing and I've been using [Typora](https://typora.io/) on my desktop but it is very Ubuntu-centric and doesn't have installers for other distributions so I may have to find something else if I start using Fedora as my main distro. Fortunately there are a lot of alternatives available and maybe I'll finally start using [Vim](https://www.vim.org/) as a replacement.

I still use [Dropbox](https://www.dropbox.com) but might switch to a private instance of [Nextcloud](https://nextcloud.com/). 

__Productivity / Other__

Other applications I tend to use are:

* [Telegram](https://telegram.org/), [Signal](https://www.signal.org/) and [WhatsApp](https://www.whatsapp.com/) for messaging.
* [1Password](https://1password.com/) as my password manager.
* [Microsoft Teams](https://teams.microsoft.com) and [Zoom](https://zoom.us/) for video calls.
* [Oracle VM VirtualBox](https://www.virtualbox.org/) for virtualization which for me is running Windows 10 to configure the GPS devices we sell.

## Cross-Platform Compatibility

If you look at the list of applications I use then I think that almost all are cross-platform (Typora is too but, as mentioned above, it has limited installation options for non-Ubuntu Linux distributions).

In terms of documents, LibreOffice seems to handle what has usually been the biggest pain-point admirably. Most documents seem to be Word or Excel files and handling them in non-Microsoft applications is pretty good these days.

I do have problems if someone sends me an Apple Pages, Numbers or Keynote document but they can usually either convert then to the Word, Excel or PowerPoint equivalent or I do it myself on one of my iOS devices.

iMessage is obviously restricted to my iOS devices but other messaging services like Signal or Telegram or WhatsApp are all available for Linux (WhatsApp in a browser).

## Lower Spec Hardware

Having covered all of that, how does this sort of setup work with a low spec computer, and in my case, a laptop with 8GB of RAM?

The short answer is that it is perfectly fine for me. I don't notice things being slow or have to sit and wait as things chug along, probably because the StarLite comes with a very respectable SSD so even if memory is paging to the drive it tends not to be a big problem.

You need to be careful of things like Firefox which can chew through RAM if you have a lot of tabs open but for part-time development, some office work and general web browsing or YouTube video watching a low RAM machine is more than adequate.

One of the joys of Linux is that there are distributions which are designed for older or lower spec hardware but the mainstream distributions and desktop environments will run perfectly well and be completely usable on something like the StarLite which, you have to remember, has been designed and built for running mainstream Linux distributions.

## Some Final Thoughts

After two years of using Linux I have no plans to go back to using Windows or macOS. I'm lucky that my confidence with computers allows me to try new things so there is no great inertia caused by familiarity and I am also lucky that my work does not need me to use a specific operating system (if I were still developing macOS or iOS apps I'd have to use a Mac).

Linux these days is a world away from where it was when I first tried it in the early 2000s and it is stable, easy to maintain, well supported and getting more and more polished. Of course there are some rough edges and the tight integration between things like iOS and macOS is missing as are some of the integrations you get between apps in macOS or iOS.

I don't expect Linux to become as mainstream or well known as Windows or macOS but it does provide a great alternative and as manufacturers create more and more computers which are designed for or come pre-installed with Linux then the barriers to entry get lower and lower. It is a viable alternative to Windows or macOS and even if you are not driven by the ideology of [open source software](https://opensource.com/resources/what-open-source) then it may just provide you with a comfortable, stable and functional computring environment which is not being driven by marketing requirements and the need to innovate and re-invent itself every few years.
