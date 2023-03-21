---
date: 2022-12-14 12:00
title: My Git Notes
categories: miscellaneous
---

This blog post is a personal reference in that I wanted to document the [Git](https://git-scm.com/) commands I use the most now that I use the command line more and more. I am publishing it as a blog post so that I can refer back to it quickly and easily. It is not a complete guide and is likely to be updated regularly.

# Branching

List the local and remote branches:

`git branch -a`

Create the specified branch and check it out:

`git checkout -b <new-branch>`

Check out the specified branch:

`git checkout <branch>`

Delete the specified branch but only if all changes have been merged:

`git checkout -b <branch> origin/<branch>`

Checks out a remote branch.

`git branch -d <branch>`

Force delete the specified branch:

`git branch -D <branch>`

Delete the specified remote branch but only if all changes have been merged:

`git push origin -d <branch>`

Rename the current branch to `<branch>`:

`git branch -m <branch>`

Remove local branches that have been tracking remote branches that have been deleted:

`git fetch --prune` or `git remote prune origin`

# Reviewing & Changing History

List commits:

`git log`

Show the details (including the diff) of the last commit:

`git show --source`

Edit the last commit message. Files can also be added via `git add <filename>` or removed via `git rm <filename>` before running this command.

`git commit --amend`

_If the commit has been pushed then the `--force` parameter will be needed: `git push --force` (note that this is more dangerous with repositories which others may be using)._
