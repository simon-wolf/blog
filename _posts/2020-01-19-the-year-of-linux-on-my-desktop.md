---
date: 2020-01-19 18:00
title: The Year of Linux on my Desktop?
categories: [computing]
tags: [linux]
---

## Introduction

Last week I decided to scratch an itch and tried using Linux for the first time in about 15 years. I wanted to see if would be possible to do my work on it now that [I no longer absolutely needed to use macOS](https://www.swwritings.com/post/2019-05-02-keep-moving).

## The Hardware

My initial plan was to try Linux in a virtual machine but my iMac, macOS Catalina and my two external display appear not to get on brilliantly well. If you do a search for `catalina sleep reboot` you'll see that it's not just me. Therefore I decided to buy a separate computer to run it on and I settled on an [Entroware Aura](https://www.entroware.com/store/aura). I didn't realise it at the time but this is an [Intel NUC](https://www.intel.com/content/www/us/en/products/boards-kits/nuc.html). Entroware ship them with [Ubuntu](https://ubuntu.com/) 18.04 LTS or [Ubuntu Mate](https://ubuntu-mate.org) 18.04 LTS and I opted for the former. It took about a week to arrive and I set up the core of what I needed in an evening.

## Getting A Feel For Things

Ubuntu is close enough to macOS that finding your way around it is not difficult in the slightest.

There are different options for installing software and [this article](https://www.ubuntupit.com/how-to-install-software-in-ubuntu-linux-a-complete-guide-for-newbie/), although ad-heavy, gives a pretty comprehensive overview of them.

All of my hardware and extra devices seem to just work. My wireless printer was detected and configured automatically, my Canon scanner, whose proprietary software was blocked by Catalina because it was 32-bit, works natively, and my Apple Magic Trackpad 2 also works which pleases me enormously (I have it connected via a cable to avoid my iMac from hijacking it).

I bought a [Bawanfa USB Switch Selector](https://smile.amazon.co.uk/gp/product/B0824YQFNWhttps://smile.amazon.co.uk/gp/product/B0824YQFNW) so that I could share my keyboard and trackpad with both my Linux box and my iMac and I power it because my keyboard, an [Ergodox EZ](https://ergodox-ez.com/) is backlit. Despite fears after reading reviews about other switchers which have problems with backlit keyboards this works flawlessly.

The Linux box is plugged into my two external displays and my iMac no longer sits between them but rather is now off to one side.

## Building A Work Environment

My initial goal is to create a work environment where I can perform out my day-job duties. The core application I need are:

*Git and a Git Client*

On macOS I have been using [Tower](https://www.git-tower.com) and heartily recommend it. On Ubuntu I am trying [GitKraken](https://www.gitkraken.com/). It is fairly simple to pick up and of course YouTube has a plethora of videos about it too. When my Pro trial is over I'm going to be tempted to buy a license but because GitKraken is cross-platform, if I abandon this project I can use it on my Mac.

*Code Editor*

During 2020 I want to get to grips with [Vim](https://www.vim.org/). I've always struggled to do this in the past despite a desire to do so because everything I hear and read about it shows me how incredibly powerful it is. In the meantime I am lucky that my IDE of choice, [Visual Studio Code](https://code.visualstudio.com/) is cross-platform.

*Work Chat*

At work we use Slack which, like VS Code, is cross-platform.

*Emails*

I'm using [Thunderbird](https://www.thunderbird.net/en-US/) which isn't terribly pretty but seems to work well. I've not used it much yet however.

*Web Browsing*

Ubuntu uses [Firefox](https://www.mozilla.org/en-US/firefox/) which I hadn't used for years. On macOS I generally used Safari and occasionally [Google Chrome](https://www.google.com/chrome/) when sites didn't behave or I wanted to run two completely separate browsing environments. I have no complaints about Firefox and I have also installed Chrome.

*Elixir, etc.*

I'd not be attempting this if the most important element, [Elixir](https://elixir-lang.org/), wasn't available on Linux. I installed it, as I do on macOS, using [asdf-vm](https://asdf-vm.com). Tools such as [Docker](https://www.docker.com/) and services like [Dropbox](https://www.dropbox.com) are all available for Linux too.

## First Impressions

These really are very early first impressions. This post is being written when I have only just started using Linux for development (one full work day plus a weekend of tinkering). However what I can say so far is that I definitely could use Linux. There has been nothing which has blocked me from earning my living so far.

I do like the feeling that I can use a Long Term Support (LTS) version of Linux which means that it is considered to be stable and is supported for five years from release. This is in stark contrast to Apple who seem determined to continue with releasing major OS updates annually which inevitably brings new bugs with it and leaves old bugs in versions of macOS which are only a year old but considered obsolete.

However I am invested in, and still enjoy using, the Apple ecosystem. Some elements could be migrated away from it (calendars, contacts, notes) but some can't (music, film and TV show purchases). And even if they could, I love iPads and Apple TVs (I'm not a huge phone user so whilst I have an iPhone I rarely use it) and my 12" MacBook is great for travelling with. In addition I work for a company whose product is a macOS application which I need to use so I am under no illusions that this is the start of me abandoning Apple's devices for a brave new world.

I think that the short term might be for me to carry on as I am right now... a Linux box for coding with an iMac next to it for other 'stuff', a MacBook for travel plus my iPad and iPhone. In the slightly longer term I could see me replacing the iMac with a Mac mini which shares a third screen with a Linux box or maybe even just my iPad on the desk for looking at contacts, notes, etc.

I'll keep you posted...
