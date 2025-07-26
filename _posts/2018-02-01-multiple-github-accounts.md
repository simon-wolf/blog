---
date: 2018-02-01 10:22
title: Working With Multiple GitHub (and Alternatives) Accounts
categories: [programming]
tags: [git]
---

## Introduction
I have multiple GitHub accounts courtesy of having several clients and a couple of my own businesses. Accessing and managing them can be a bit of a juggling act and I frequently forget how to do things so I decided that it was time to document various aspects of what I do.

## Authentication Via SSH
I manage access to my GitHub accounts via SSH. This means that I can enable two-factor authentication and still have simple access via Terminal or a Git client application.

GitHub has some very [comprehensive instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) about how to set all of this up so follow those if you need to create a SSH key and add it to your account.

When you have multiple GitHub accounts I'd strongly suggest using different SSH keys for each (if you really want to you could go so far as generating SSH keys for each repository). Just remember to give them meaningful names (client1_id_rsa, client2_id_rsa, company1_id_rsa, etc.).

I would strongly recommend keeping a secure backup of your SSH keys (I use [1Password](https://1password.com) for this).

I would also suggest copying the public and private SSH keys to other computers that you use so that you're not generating and maintaining keys for different accounts for different computers.

## Using The SSH Keys
Most Git clients such as [Tower](https://www.git-tower.com) will allow you to configure your accounts and the SSH keys each uses. However if you use Git on the command-line then juggling multiple accounts and SSH keys is much easier if you use an SSH config file.

The config file allows you to create memorable names for servers and store information such as the domain name, your username and the SSH key file to use.

	Host github-client1
		HostName github.com
		User git
		IdentityFile ~/.ssh/client1_id_rsa
	Host github-client2
		HostName github.com
		User git
		IdentityFile ~/.ssh/client2_id_rsa
	Host github-company1
		HostName github.com
		User git
		IdentityFile ~/.ssh/company1_id_rsa

To clone a repository from client1's account you'd use:

    $ git clone git@github-client1:orgname/repository_name.git

*If you have problems with this then the first thing to check is that the SSH keys have been added to the ssh-agent.*

## Git User
Git can store 'global' configuration settings in the `.gitconfig` file in your user's home folder. Amongst other things this will contain your Git user details:

    [user]
        name = Joe Bloggs
        email = joe@bloggs.com

However when you are working with multiple GitHub accounts you probably want your commits to be attributed to another user.

Each Git repository allows you to configure a user which overrides the global one. The details are stored in the `config` file in the `.git` folder.

You can set the user and/or email address by going into the repository's folder in Terminal and using:

    git config user.name = 'name'
    git config user.email - 'email_address'

### Changing The Git User Retrospectively
If you already have commits from the wrong user in your repository there are ways to rewrite the history.

GitHub provide [a nice script](https://help.github.com/articles/changing-author-info/) for this.

Take note of the warning and note on that page.
