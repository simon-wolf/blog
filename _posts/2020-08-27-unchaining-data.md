---
date: 2020-08-27 21:30
title: Unchaining Data
categories: [computing]
tags: [productivity, apple]
---

## Introduction

Plain text files are very portable. There is no tie-in to any particular editor or application or even operating system. The problem is that most documents we create are not stored as plain text and so our data is chained up and restricted to where and how it can be accessed and used.

In many cases this is a justified or necessary 'expense'. A styled document such as a product brochure is simple to put together in Word and a business budget plan can be created easily in Excel. However perhaps not everything needs to be locked to complex file formats (proprietary or open-source).

In plenty of other cases however it is not and planty of data can be stored in more open ways.

## Notes

Nearly two years ago [I wrote about]({% post_url 2018-11-14-from-evernote-to-notes %}) moving from [Evernote](https://evernote.com/) to [Apple's Notes](https://en.wikipedia.org/wiki/Notes_(Apple)) and until I switched to Linux and realised that the move was going to stick I was very happy with Notes. However I now want something more flexible and ideally something where I won't have to migrate from one application to another. 

Talking of migrating, I have discovered that Notes' [AppleScript](https://en.wikipedia.org/wiki/AppleScript) support is broken in [macOS Catalina](https://www.apple.com/macos/catalina/) so I now have to manually 'export' almost 1,000 notes. On the plus-side, this does convince me that keeping notes as text-based files is the way to go.

I generally have two types of things I store in Notes: text-based notes and PDF files. The latter are generally scans of things like invoices or important documents I want to hang on to. I plan to move the PDFs into [Dropbox](https://www.dropbox.com/) (for now) and transfer the text-based notes into individual text files which I will store in a [Git](https://git-scm.com/) repository.

I am not sure that this is going to be the permanent solution but having my data back into a flexible format which I have complete control over is definitely the first step in the right direction.

## Spreadsheets

I recently searched my MacBook to see how many [Numbers](https://www.apple.com/numbers/) spreadsheets I had that I still actually needed. The answer was one and it is the one I store my monthly expenditure/budget details in. I essentially use it to track my known outgoings such as regular bills, rent, my daughter's allowance, etc. so that when I get paid I know how much has to go into my household bills bank account and any manual payments I have to make.

I decided to try something different with this and I moved the data into a plain text JSON file and then wrote a very simple [Python](https://www.python.org/) script which loads the file and totals up the planned spending and summarises it into what amount I need in the bills account, lists the manual payments I need to make, etc. As and when bills change I simply need to edit the JSON file and when I next run the script I get the new totals.

## Word Processing

Again, a search of my MacBook showed compatarively few [Pages](https://www.apple.com/pages/) documents that I need to keep as Pages files. Some can be converted into PDFs for archiving, some can become Markdown files and only a handful need to be kept as word processing files. These I will convert to [Microsoft Word](https://www.microsoft.com/en-gb/microsoft-365/word?rtc=1) files and then convert to [LibreOffice Writer](https://www.libreoffice.org/discover/writer/) files so that they are at least cross-platform.

In an ideal world I'd learn [LaTeX](https://www.latex-project.org/) and at least have them as text-based documents but life is too short for some things, particularly when you don't need to do it very often.

## Calendars, Address Book, Tasks, etc.

Fortunately my current calendar and contacts systems (both [iCloud](https://www.apple.com/icloud/)) use CalDAV and CardDAV which is an open standard. For now I will continue to use iCloud but I may move to a more open provider or even set up my own server (which could also be used as a Git server rather than using a service such as [GitHub](https://github.com/) for my notes. Whilst CalDAV and CardDAV are not plain text they are well established, open standards.

I have relatively few tasks I need to keep track of (probably around 20, of which over half are repeating reminders for things I need to do regularly or semi-regularly). I'm not sure what I will do about these yet. Whilst there are several systems I want to look at which use plain text data files I am thinking about using this as excuse to write my own Python-based system.

## Conclusion

Whilst this is not a definitive list of the types of files I would like to make more flexible and portable it covers the core of them. Some things are easy to tackle (notes) whilst some have to remain as more complex files (word processing documents) and some present the opportunities to try something new (tasks and spreadsheets replaced by plain text data files and Python-based parsers).

I expect that I will add some follow-up posts to this about specific solutions and more file types as I find them.
