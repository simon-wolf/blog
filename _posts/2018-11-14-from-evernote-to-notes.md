---
date: 2018-11-14 10:32
title: From Evernote to Notes
categories: [computing]
tags: [productivity, apple]
---

## Introduction
I have been using [Evernote](https://www.evernote.com) for several years and I pay for a Premium plan because I need to use more than two devices and some of my attachments are over 25MB in size. The system is very capable and includes some really nice features including OCR'ing text in images (really handy if you take a photo of something like a business card).

However the application is also full of features I don't need or use when I actually looked at what I wanted to use it for it was a very small set of requirements:

1. Be a store of things I want to note down.
2. Be a repository for documents I need to keep. These are things like my annual home contents insurance documents or scanned receipts which acts as a product guarantees.
3. Be a repository for documents and notes I currently need. These are things like papers for an upcoming meeting or copies of documents relating to filing a current set of account. Essentially they are items for an on-going project or event.

Having fairly recently abandoned complex Getting Things Done apps and switched to Apple's Reminders app I decided to have a proper look at [Apple's Notes app](https://support.apple.com/en-gb/guide/notes/welcome/mac).

## The Notes App
Apple's Notes app comes with both iOS and macOS and it uses iCloud to sync the data between all of your devices (although you can also use other services such as Gmail and Exchange too).

Notes are stored in folders and a nice discovery was that it also supports sub-folders too. This helps enormously with my third requirement... I can have a folder of notes relating to a community project and a sub-folder called something like '2018-11 Meeting' which contains notes and documents for that particular meeting.

Notes also contains some advanced features. You can share and collaborate on notes, scan documents using an iPhone (it's really just taking a photo which is then optimised but you can add a note on macOS by 'scanning' on an iPhone which is clever), mark up attached documents, search using Siri and more. Take a look at the [Notes User Guide](https://support.apple.com/en-gb/guide/notes/welcome/mac) for full details.

## The Concerns
Whilst Notes ticks most of my boxes there are a couple of features I will miss and some which may prevent others from migrating to it.

### OCR

There is no OCR support for images. If you scan something like a business card the text in it is not searchable. Hopefully this will be added by Apple at some point but I will look into work-arounds and update this article if I find any.

### Tags

Notes does not support tags. If you rely on tags to find or categorise things then you are going to struggle with Notes. Subfolders might help if you just add single tags to items to help classify them and you could always use your own delimited list format to add searchable text. Something like `|Gordon Ramsay|Beef|Main|Winter|` would allow you to tag a recipe and search for all beef-based main courses by searching for `|Beef| |Main|`.

### Sync Issues

Whilst iCloud is pretty reliable and consistent I did receive [one tweet](https://twitter.com/varunorcv/status/1061491617603842049) about a sync bug someone had found after asking on Twitter if people had encountered problems.

* Open any existing note
* Add two new lines anywhere in the middle

```
Capybara
Aardvark
```

* Select both & CUT
* Replace with

```
Nobelium
Fermium
```

* Select both & CUT
* Run a keyword search from HOME & iOS still points to it

### Lock-In

Exporting notes from Evernote is really simple (see below). Exporting notes from the Notes app is not. You can generate PDFs for each note but that's it.

This does raise a question about lock-in and whether it is a good idea to adopt Notes if you can't get the data into another application if you want to. I will be looking into [AppleScripts](https://en.wikipedia.org/wiki/AppleScript) to create exports (of only for backup purposes at the moment) however and will update this article with any findings.

## Migrating My Notes
The great news is that migrating from Evernote to Notes is really simple. You can export your Evernote notes in their Evernote XML Format and Notes can read it and will import everything seamlessly... almost...

The problem is that when you import an Evernote XML Format file into Notes the notebook information is lost and all of your notes end up in one folder. Therefore you need to export the contents of each Evernote notebook into its own file and then import them individually into Notes (renaming the import folder each time).

## Conclusion
It has only been a few days since I migrated my notes over but so far I am very happy. Sub-folders are a really nice addition for me and I'm doing things I could have done but tended not to with Evernote. For example, I sat on the sofa with my iPad and an Apple Pencil and added annotations to a PDF I was reviewing. Evernote can do this too (but it is a premium feature) but I'd never done it and when I did look at it for this article the annotation tools felt overly complex and complicated compared to Apple's minimalist approach. And that is a great way to sum up Evernote versus Notes too.
