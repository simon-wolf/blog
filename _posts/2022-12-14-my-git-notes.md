---
date: 2022-12-14 12:00
title: My Git Notes
categories: miscellaneous
---

This blog post is a personal reference in that I wanted to document the [Git](https://git-scm.com/) commands I use the most now that I use the command line more and more. I am publishing it as a blog post so that I can refer back to it quickly and easily. It is not a complete guide and is likely to be updated regularly.

# Branching

`git branch -a`

Lists the local and remote branches.

`git checkout -b <new-branch>`

Create the specified branch and checks it out.

`git checkout <branch>`

Checks out the specified branch.

`git branch -d <branch>`

Deletes the specified branch but only if all changes have been merged.

`git branch -D <branch>`

Force deleted the specified branch.

`git push origin -d <branch>`

Deletes the specified remote branch but only if all changes have been merged.

`git branch -m <branch>`

Renames the current branch to `<branch>`.

# Reviewing & Changing History

`git log`

Lists commits.

`git show --source`

Shows the details (including the diff) of the last commit.

`git commit --amend`

Edits the last commit message. Files can also be added via `git add <filename>` or removed via `git rm <filename>` before running this command.

If the commit has been pushed then the `--force` parameter will be needed: `git push --force` (note that this is more dangerous with repositories which others may be using).

