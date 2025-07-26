---
date: 2017-05-25 15:15
title: Pip and Virtual Environments
categories: [software development]
tags: [python]
---

## Introduction
The contents of this post are based on a blog post written by Jamie Matthews which is called, '[A non-magical introduction to Pip and Virtualenv for Python beginners](https://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)'. After reading this post it is probably worth going and reading his because it does explain things in more detail and very possibly more clearly. However I'm presenting a cut-down version because, if you are using Python 3.3 or higher, virtual environments are built-in. From Python 3.5 you use the [venv](https://docs.python.org/3.7/library/venv.html) command which in Python 3.3 and 3.4 was called `pyvenv`. Jamie's post discusses using [virtualenv](https://virtualenv.pypa.io/en/stable/) instead.

## The Python Package Index
Python has a huge library of third-party packages (as of writing there are 108,996) which are stored in the [Python Package Index](https://pypi.python.org/pypi) (known as PyPI).

## Installing Packages
Python always included a package manager called `easy_install`. However there is a better tool called [pip](https://pip.pypa.io/en/stable/) which may come installed with Python too. If it does then be sure to [upgrade it](https://pip.pypa.io/en/stable/installing/#upgrading-pip). If it doesn't then you can either install it using [a script](https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py) or via easy_install:

    $ sudo easy_install pip

## Don't Install Packages Globally
If you use pip (or easy_install) to install a package it will be installed globally. This means that it is available to Python scripts wherever they are on your computer. This might seem like a splendid idea bit it isn't. The problem is that your projects (and projects created by other people which you might choose to use or contribute to) can have different, often conflicting, package requirements. If you have a package installed globally then you can only have one version of it installed. The way you get around this is by using virtual environments.

## Virtual Environments With venv
A virtual environment is a walled garden which encloses your Python project. Any third-party packages your project uses are contained within the walled garden which means that each project can control the versions of packages it uses.

Setting up a virtual environment with [venv](https://docs.python.org/3.7/library/venv.html) is as simple as opening a Terminal window, navigating to the project's folder and typing:

    $ python3 -m venv [ENV_DIR]

where ENV_DIR is the name of the folder you want to store the environment-specific files and folders in. I tend to just use `env` for the folder name and in the code samples below that's what I'll use. Just remember that you can call it whatever you want.

In the above, `python3` is going to pick up the default version of Python 3 that you have installed. You can also use specific versions of Python:

    $ python3.5 -m venv env

Inside the `env` folder you'll find a number of files and folders but the key things to note are that it contains a copy of the Python binary, the Python standard library, a copy of pip, and a site-packages folder which is where the local versions of third-party packages are stored.

## Installing Packages Inside A Virtual Environment
With the above in mind, to install a package locally you need to use the local version of pip. This is stored in the bin folder in the env folder so to install a package, from the top-level project folder you'd type:

    $ env/bin/pip install [PACKAGE_NAME]

Similarly, if you want to run your code using the version of Python tied to your virtual environment you should use:

    $ env/bin/python [python_script].py

## Activating The Virtual Environment
To avoid having to type `env/bin/` before commands such as `pip` and `python` you can 'activate' the virtual environment. This is done via:

    $ source env/bin/activate

When you do this you'll see that your Terminal prompt changes so that it is prefixed with the name of the virtual environment folder:

    (env)$

Now you can install packages simply by typing:

    (env)$ pip install [PACKAGE_NAME]

You can deactivate the virtual environment by closing the Terminal window or by typing:

    (env)$ deactivate

The Terminal prompt should revert to its normal state:

    $

## Deleting The Virtual Environment
If you want to delete a virtual environment simply make sure that it is not activated and delete the `env` folder.

## Version Control
I exclude the virtual environment folder from my Git repositories and simply recreate them on computers as and when I need to.

However, so that I can quickly install any pip packages I do use pip Requirements Files and they are included in the version control repository.

## Requirements Files
A pip [requirements file](https://pip.pypa.io/en/stable/user_guide/#requirements-files) contains a list of packages. To generate a list of packages you use:

    (env)$ pip freeze > [REQUIREMENTS_FILE_NAME]

It's fairly standard to use requirements.txt as the REQUIREMENTS_FILE_NAME.

To install the packages listed in the requirements file you use:

    (env)$ pip install -r [REQUIREMENTS_FILE_NAME]

## Other pip Commands
It is worth looking through the [documentation](https://pip.pypa.io/en/stable/) to see what else pip can do but I tend to use two other pip commands the most.

To uninstall a package:

    (env)$ pip uninstall [PACKAGE_NAME]

To list the packages in a project:

    (env)$ pip list
