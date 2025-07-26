---
date: 2017-05-25 15:00
title: Visual Studio Code for Python Development
categories: [programming]
tags: [python]
---

## Introduction
This blog post gives a brief overview about how I've settled on using Visual Studio Code for Python development and describes the basic configurations I'm using.

## Finding An IDE
As a developer I have numerous applications I use for writing code. These range from Apple's [Xcode](https://developer.apple.com/xcode/) to text editors such as [BBEdit](http://www.barebones.com/products/bbedit/) with things things like [CodeRunner](https://coderunnerapp.com) in between.

When I started writing [Python](https://www.python.org) code I mainly used BBEdit and CodeRunner but I wanted to find a better tool for the job. Neither BBEdit nor CodeRunner are bad, they just didn't suit my workflow particularly well. I wanted an IDE rather than a pure editor (which saved me from hurling myself down the rabbit holes of [Vim](http://www.vim.org) and [GNU Emacs](https://www.gnu.org/software/emacs/)) and whilst there is a wide selection I had two in mind.

[PyCharm](https://www.jetbrains.com/pycharm/) by JetBrains is a highly regarded IDE and I use [WebStorm](https://www.jetbrains.com/webstorm/) for JavaScript coding. However to use it I was going to have pay JetBrains £149 (I'd buy a license as a business since I'll be using Python for a mix of business and personal projects) and I already knew of a cheaper alternative I could try first.

In addition to using WebStorm for JavaScript coding I'd tinkered with Microsoft's [Visual Studio Code](https://code.visualstudio.com). It's a lightweight IDE which uses extensions to support multiple languages, themes, debuggers and other services. I really liked it but since I'd already bought a license for WebStorm and become familiar with it I hadn't used it a huge amount. Python development seemed like the perfect opportunity to dig into it a bit more.

## Setting Up Visual Studio Code
Once you have downloaded and installed Visual Studio Code you will need to configure it for Python. You can do a lot of this via the Command Palette which is available from the View menu or via `Cmd+Shift+P` on a Mac or `Ctrl+Shift+P` on Windows and Linux. To use the Command Palette you type in what you are looking for but because it filters the results you can usually get away with just typing a few characters.

### Add Code to Your Path
If you add the `code` command to your path you can launch or activate Visual Studio Code from a Terminal window. To add it, open the Command Palette and find:

    Shell Command: Install 'code' command in PATH

### Adding Python Support
Most people use [Don Jayamanne's Python extension](https://github.com/DonJayamanne/pythonVSCode) to add Python support to Visual Studio Code. To do this you need to view the Extensions palette which can be done via the View -> Extensions menu item or by clicking on the Extensions button in the sidebar or via the Command Palette:

    View: Show Extensions

In the Extensions palette search for `Python` and Don's extension should be at or near the top.

### ctags
Although it is optional I'd recommend installing [ctags](http://ctags.sourceforge.net) which helps Visual Studio Code index and provide Intellisense for Python and your own code. 

On a Mac you can install it with [Homebrew](https://brew.sh):

    brew install ctags
    
On Linux you can install it with:

    sudo apt-get install exuberant-ctags

On Windows you'll need to download it as a binary and place it somewhere in your path.

## The Python Interpreter
When you open a project in Visual Studio Code it usually does a fairly good job of picking the right version of Python to work with but it is worth double-checking. To do this, use the Command Palette:

    Python: Select Workspace Interpreter

Remember that if you are using a virtual environment (and you should be... see my [pip and Virtual Environments]({% post_url 2017-05-25-pip-virtual-environments %}) blog post for details) you should select its Python interpreter.

## Settings
Visual Studio Code has two types of settings. There are user settings, which apply to all projects, and workspace settings, which are project-specific.

The settings are stored in JSON files and so workspace settings can be added to your version control system. On a Mac the user settings are stored in `~/Library/Application Support/Code/User/settings.json` so they can be easily transferred to a different Mac if you choose to do so.

When you change the Python interpreter as mentioned above it is stored in the workspace settings as (for example):

    {
        "python.pythonPath": "${workspaceRoot}/env/bin/python3"
    }

My user settings are:

    {
        "editor.fontFamily": "Inconsolata-dz",
        "editor.fontSize": 14,
        "workbench.colorTheme": "Monokai Dimmed",
        "python.formatting.formatOnSave": true,
        "python.linting.pylintEnabled": false,
        "python.linting.flake8Enabled": true,
        "files.exclude": {
            "**/*.pyc": true,
            "**/*.map": true,
            "**/*__pycache__": true
        }
    }

### Look & Feel
 The first three settings, "editor.fontFamily", "editor.fontSize" and "workbench.colorTheme", simply define the look of the IDE.
 
 (*I've used [Inconsolata-dz](http://nodnod.net/2009/feb/12/adding-straight-single-and-double-quotes-inconsola/) for a number of years now as my fixed-width font of choice.*)

### Python Formatting
Whilst Visual Studio Code does a fairly good job of formatting code nicely as you type it, [autopep8](https://pypi.python.org/pypi/autopep8) does a better job each time you save your files and this setting enables it:

    python.formatting.formatOnSave

If the autopep8 package is not installed in your virtual environment Visual Studio Code offers to install it.

You can read more about the formatting options in Don Jayamanne's extension in [the extension's wiki](https://github.com/DonJayamanne/pythonVSCode/wiki/Formatting).

### Python Code Linting
Code linting is a process whereby your code is analysed and any problems are highlighted. By default linting is enabled and uses [pylint](https://pylint.readthedocs.io/en/latest/).

I tend to find pylint a bit too strict and use [flake8](https://pypi.python.org/pypi/flake8) instead. To achieve this I disable linting with pylint and enable it with flake8:

        "python.linting.pylintEnabled": false,
        "python.linting.flake8Enabled": true,

If flake8 (or pylint if you choose that) is not installed in your virtual environment Visual Studio Code offers to install it.

You can also enable both at the same time. Or add more linters into the mix.

You can read more about the linting options in Don Jayamanne's extension in [the extension's wiki](https://github.com/DonJayamanne/pythonVSCode/wiki/Linting).

### Excluded Files
The excluded files section of the settings excludes certain files from showing up in the Visual Studio Code Explorer sidebar which eliminates clutter and hides the files you don't need to interact with.

---

If you are interested in using Vim or GNU Emacs then here are two articles which might interest you:
* Using [Vim](https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/) for Python development.
* Using [GNU Emacs](https://realpython.com/blog/python/emacs-the-best-python-editor/) for Python development.
