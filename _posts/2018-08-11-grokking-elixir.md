---
date: 2018-08-11 12:12
title: Grokking Elixir
categories: [software development]
tags: [elixir]
---

## Introduction
Late last September I started being interested in [Elixir](https://elixir-lang.org). As the website says, "Elixir is a dynamic, functional language designed for building scalable and maintainable applications." Elixir uses the [Erlang](http://www.erlang.org) Virtual Machine and Erlang is a battle-tested language which was originally developed by [Ericsson](https://en.wikipedia.org/wiki/Ericsson) for telephony applications which needed to be distributed, fault-tolerant and highly available. Elixir is really a more modern, more readable, less verbose version of Erlang.

My interest was partly academic but I maintain the back-end and front-end code for a system which needs to be reliable, stable and scalable. Elixir seemed to be perfectly suited to that sort of role so I had a vague plan to re-write some or all of it in Elixir.

Coming from a background of object-orientated languages I was expecting the biggest stumbling block to be the switch to functional programming but that bit seemed to click for me very quickly. The first paragraph of [Wikipedia's functional programming article](https://en.wikipedia.org/wiki/Functional_programming) gives a good summary of how it differs from object-orientated programming.

## Grokking The Basics
Grokking the basics of the Elixir language wasn't terribly difficult. This is partly because [the documentation](https://elixir-lang.org/docs.html) is great (and I love the fact that documentation, as well as testing, is a first class citizen in the Elixir world) and partly because it's not a huge, sprawling language. By contrast, [Swift](https://swift.org) can give me imposter syndrome despite having been a professional developer for almost 25 years and despite having been writing code for Apple's ecosystem for a decade.

Two books which really helped me with the language were [Introducing Elixir](http://shop.oreilly.com/product/0636920030584.do) and [Learn Functional Programming with Elixir](https://pragprog.com/book/cdc-elixir/learn-functional-programming-with-elixir).

## Processes and Concurrency
Once you are comfortable with the basics the next area to tackle is that of processes and concurrency.

A core concept in Elixir is that you can create processes which are small packages of code which can be run independently from each other and concurrently. You can send messages between processes and processes can be monitored and supervised so that if one crashes it can be restarted automatically.

And that last point should be the one which makes you realise that an Elixir process is not a native operating system process. They are processes which exist in the Erlang VM and because of the way that the Erlang VM was designed you don't have the usual concurrency worries about threads, mutability and performance and an Erlang VM can spawn hundreds of thousands of processes on a fairly modest computer.

The book which best explained this to me was Dave Thomas' [Programming Elixir 1.6](https://pragprog.com/book/elixir16/programming-elixir-1-6). Part II, Concurrent Programming, starts by explaining how you can spawn processes, send messages between them, link them, have one monitor the other and have them communicate across local networks and even the internet. As Dave says, getting used to using processes can take a while but they are so central to Elixir that you need to stick with it.

After covering processes at a low-level he moves on to explaining OTP servers and supervisors. OTP stands for Open Telecom Platform but the full name, which is an obvious tie back to Ericsson, is rarely used now. In a very superficial nutshell, OTP simplifies using and managing processes.

Then in chapter 19 I discovered the thing I can point to and say that it helped me grok Elixir and how my knowledge of the language could be translated into a viable application. In this chapter Dave walks through designing, structuring and creating an application which finds duplicate files on your computer. The application takes a lot of the process and OTP theory and puts it into the context of a real application.

## The Next Steps
So far I've mentioned three books which have helped me get to grips with Elixir. I know that I still have a lot to learn and a lot of gaps to fill but at the moment I feel confident enough to start re-writing some of the system I mentioned at the start of this article.

However during the last year I've bought other books, taken a couple of video courses, watched some videos on YouTube, subscribed to some newsletters and joined a forum, all of which I'll list below.

Before I do that I'll mention that the official Elixir site hosts [the Elixir documentation](https://elixir-lang.org/docs.html) which is really good and that there are also some [guides](https://elixir-lang.org/getting-started/introduction.html) and a great list of [learning resources](https://elixir-lang.org/learning.html) there too.

### Books
[Introducing Elixir](http://shop.oreilly.com/product/0636920030584.do) was a good first-pick book choice and it was clearly written. However I do note that some Amazon reviewers have said that it's not ideal if Elixir is your first programming language. Mind you, if you're completely new to programming a language like [Python](https://www.python.org) might be more appropriate anyway.

Having said that, I think that I would now suggest [Learn Functional Programming with Elixir](https://pragprog.com/book/cdc-elixir/learn-functional-programming-with-elixir) to someone as a first Elixir book. It is fairly short (around 150 pages) but it is very good for learning the basics of Elixir as a language. I particularly liked the way it explained anonymous and named functions, pure and impure functions and recursion. It was also really good for covering and explaining some of the symbols you'll see in Elixir code such as =>, -> and <-.

I would then definitely suggest Dave Thomas' [Programming Elixir 1.6](https://pragprog.com/book/elixir16/programming-elixir-1-6) book. As explained above, I found it really good for covering concurrency, processes, the basics of OTP and, most valuably for me, how to construct an actual application.

Now that I'm happy with the basics of OTP I'm going to read [The Little Elixir & OTP Guidebook](https://www.manning.com/books/the-little-elixir-and-otp-guidebook). I bought this a while ago but at the time it was way ahead of where I was so this is the first book I'll be revisiting.

I had a bit of a splurge and bought most of the Elixir-related books published by [The Pragmatic Bookshelf](https://pragprog.com/):

* [Programming Phoenix 1.4](https://pragprog.com/book/phoenix14/programming-phoenix-1-4) covers the Phoenix web framework. The system I'm considering replacing has a web application written in JavaScript using the Meteor framework. I want to see if Phoenix would be a viable replacement.
* [Craft GraphQL APIs in Elixir with Absinthe](https://pragprog.com/book/wwgraphql/craft-graphql-apis-in-elixir-with-absinthe) is fairly self-explanatory and GraphQL has interested me for a while. Being able to construct APIs for the system for mobile apps to use would be a good excuse to get to grips with it.
* [Adopting Elixir](https://pragprog.com/book/tvmelixir/adopting-elixir) covers the more practical aspects of using Elixir such as how to build a team of Elixir developers, how to migrate over to Elixir, deploying and monitoring applications, etc. The deployment and monitoring sections are the ones which most interest me.
* [Functional Web Development with Elixir, OTP, and Phoenix](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix) may be a bit redundant in light of the other books but I may read it after The Little Elixir & OTP Guidebook to give my knowledge some reinforcement.
* [Programming Ecto](https://pragprog.com/book/wmecto/programming-ecto) will be good for more in-depth coverage of Ecto than any of the other books are likely to give me.

In addition to these, [Property-Based Testing with PropErr, Erlang, and Elixir](https://pragprog.com/book/fhproper/property-based-testing-with-proper-erlang-and-elixir) has just had a beta release and it looks interesting but may be too Erlang-focused for me at this point. I think that I probably do need to learn some Erlang since Elixir can use Erlang's libraries and uses the Erlang VM so maybe I'll come back to this once I've done that.

I know next-to-nothing about Elixir macros at this point but when I do learn more about them I may well buy [Metaprogramming Elixir](https://pragprog.com/book/cmelixir/metaprogramming-elixir) even though it is a few years old.

### Videos & Video Courses
[The Coding Gnome](https://coding-gnome.com) is Dave Thomas' online course site. At the moment there is only one course available, Elixir for Programmers, but it is a great course and well worth taking. I'm going to re-take it once I have a spare weekend just to revisit and reinforce some of the ideas he proposes.

I really hope that Dave creates some additional courses too. The site also includes links to some of his recent conference talks which are all worth watching and his blog which is worth reading. Dave can be a bit outspoken about Elixir's best practices and isn't shy about critiquing them and offering his alternative takes and whether you agree with him or not his views are definitely worth listening to.

### Newsletters
[ElixirWeekly](https://elixirweekly.net) is a very good weekly newsletter which is sent out each Thursday.

[Elixir Radar](http://plataformatec.com.br/elixir-radar) is published by [Plataformatec](http://plataformatec.com.br), the company which created Elixir.

### Forums, Twitter & Miscellaneous
[Elixir Forum](https://elixirforum.com) seems to be the de-facto forum and is a friendly, welcoming place.

As well as hosting a newsletter, [Elixir Radar](http://plataformatec.com.br/elixir-radar) has a job board.

On Twitter I follow these news and information-related accounts:

* [Elixir Lang](https://twitter.com/elixirlang)
* [Elixir Tip](https://twitter.com/ElixirTip)
* [Elixir Outlaws](https://twitter.com/ElixirOutlaws)
* [Elixir School](https://twitter.com/elixirschool)
* [Hex](https://twitter.com/hexpm)
* [Elixir Status](https://twitter.com/elixirstatus)
