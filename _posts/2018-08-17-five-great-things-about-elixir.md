---
date: 2018-08-17 10:00
title: Five Great Things About Elixir
categories: [programming]
tags: [elixir]
---

## Introduction
My career as a developer has evolved through various languages and platforms during the last 20-something years and for the last decade I've mainly focused on Apple's macOS and iOS platforms using Objective-C and Swift whilst occasionally using other languages such as Python and JavaScript. Occasionally I hear about 'the next big thing' and take a look at what the fuss is about and one of them has really piqued my interest: [Elixir](https://elixir-lang.org). 

I thought it would be fun to put together a top five list of the things I really like about it so, in no particular order...

## Functional Programming
I've been used to object-orientated programming where you think in terms of classes, methods and properties. For much of the time when you are writing object-based code you are dealing with state. You call an object's method which can change that object's properties and of course an object's methods can also change the properties of other objects.

Functional programming takes a different approach. Functions are the basic building blocks, all values are immutable and the code is declarative.

To illustrate the difference between declarative and imperative programming I'll use an example of converting a list of strings to uppercase (shamelessly stolen from [Learn Functional Programming with Elixir](https://pragprog.com/book/cdc-elixir/learn-functional-programming-with-elixir) by [Ulisses Almeida](https://twitter.com/ulissesalmeida). I'll avoid using the high-order function, [map](https://en.wikipedia.org/wiki/Map_(higher-order_function) so that you can see the naive way to solve the problem in both types of language.

In an imperative language (using JavaScript as an example) the *how* can overwhelm the *what*. The code needed to enumerate through the list dominates the function and you are also having to create a new list, push the capitalised items into it and return it.
```
function capitaliseList(list) {
	var newList = [];
	for (var i = 0; i < list.length; i++) {
		newList.push(list[i].toUpperCase());
	}
	return newList;
}
```

In a declarative language you focus more on the *what* than the *how*. Here's the Elixir version of the above code:

```
def capitalise_list([]) do
  []
end
def capitalise_list([head | tail]) do
  [String.upcase(head) | capitalise_list(tail)]
end
```

That's probably impenetrable unless you know some basic Elixir but it uses recursive function calls instead of creating a `for` loop to enumerate through the list. All of the boilerplate which create a new list, enumerates through it, pushes the uppercase string into it and then returns the list is replaced by one line where you convert the first item of the list to uppercase and call the function again with the remainder of the list.

Obviously there are cleaner ways to do this in imperative languages but the key point about a declarative language is that you are not having to manage the enumeration or setting up a new list; you are simply converting part of the list to uppercase and processing the remainder of the list.

Many people struggle getting their head around functional programming after being used to object-orientated programming but my experience has been that if you don't focus on trying to write declarative, functional code but rather follow the language's inherent style then it just happens. Other languages need their own version of the term [Pythonic](https://stackoverflow.com/questions/25011078/what-does-pythonic-mean#25011492).

## Documentation
This isn't about [Elixir's documentation](https://elixir-lang.org/docs.html) although it is great and there are also some very helpful [guides](https://elixir-lang.org/getting-started/introduction.html) and a solid list of [learning resources](https://elixir-lang.org/learning.html). This is about the fact that in Elixir you are encouraged to write documentation in your code and it is then trivial to convert it into good looking HTML pages. This can be handy for your own code but comes into its own for packages.

Alongside the Elixir and Erlang package manager, [Hex](https://hex.pm), sits [Hexdocs](https://hexdocs.pm) where the documentation embedded in the code inside packages is published. It all follows a standard style which makes it very easy to follow. As an example, take a look at [the documentation for Poison](https://hexdocs.pm/poison/Poison.html), a JSON library.

If you take a look at the documentation for [the decode!/1 function](https://hexdocs.pm/poison/Poison.html#decode!/1) (in Elixir you refer to functions by their name and arity and here the arity is one... the function takes one argument) you will notice two things:

1. Although Elixir is weakly typed you can specify types and you can then use Erlang's static analysis tool, [Dialyzer](http://erlang.org/doc/man/dialyzer.html), to check your code (in Elixir [Dialyxir](https://github.com/jeremyjh/dialyxir) is a great way to simplify this).
2. The documentation contains example code snippets. These snippets, called doctests, can be included in your testing workflow and are a great way to make sure that the documentation doesn't become stale.

I love the fact that you are encouraged to document your code and my only wish is that you could document private functions although I understand why that's something you get warnings about. Rather you are encouraged to just add comments.
 
## The Pipe Operator
When I need to chain commands together I'm used to writing code like this:

```
var firstName = "Simon".toUpperCase().split("").reverse().join("")
```

Alternatively you can split it all up:

```
var firstName = "Simon"
firstName = firstName.toUpperCase()
firstName = firstName.split("")
firstName = firstName.reverse()
firstName = firstName.join("");
```

The first isn't brilliantly readable (it is definitely not skimmable) and the second contains a lot of repetitive code.

In Elixir you can dramatically improve the second example to make it shorter and more readable using the pipe operator:

```
first_name = "Simon"
|> String.upcase
|> String.split("", trim: true)
|> Enum.reverse
|> Enum.join
```

*Before Elixir users email me to tell me about the String.reverse/1 function, I wanted to provide code which would match the JavaScript version.*

The pipe operator passes the result of one function (or an initial value) to the next function as the first parameter of that next function.

The String.upcase/1 function has an arity of one and it is meant to be passed the string which you want to convert to uppercase. Because the pipe operator automatically passed in that string you don't have to specify it.

Instead of writing:

```
first_name = "Simon"
first_name = String.upcase(first_name)
```

you write:

```
first_name = "Simon"
|> String.upcase
```

Similarly the verbose version of `|> String.split("", trim: true)` would be `first_name = String.split(first_name, "", trim: true)`.

The initial `first_name = "Simon"` means that the final output of the pipeline will be stored in the `first_name` variable. If you don't need to access the final value at the end of the pipeline because, for example, you are returning it at the end of a function (and Elixir automatically returns the last value in a function... no more `return` statements), you would just start it with the initial value (which can also be a function):

```
"Simon"
|> String.upcase
|> String.split("", trim: true)
...
```

```
String.upcase("Simon")
|> String.split("", trim: true)
...
```

And going all the way back to the first example, you can use the pip operator inline:

```
first_name = "Simon" |> String.upcase |> String.split("", trim: true) |> Enum.reverse |> Enum.join
```

The pipe operator is a really nice way to create readable code and it also encourages you to break your code into small, focused functions which can be added to pipelines.

## Concurrency
The main push in improving computing power is no longer via processor speed improvements but rather by adding more cores. Therefore the way to make your applications faster is to spread the workload across those multiple cores.

Elixir uses the Erlang VM and one of its strengths is that it allows you to run lots of processes (and we're talking tens or hundreds of thousands) concurrently, spreading them across multiple cores. In addition, because functional programming transforms state rather than mutating objects you not only remove one of the main complexities that multi-threaded object-orientated languages have but you also have a powerful, simple way to maximise your computing power.

I wrote a bit more about Processes and Concurrency in my [Grokking Elixir](2018-08-11-grokking-elixir) blog post.

## The Community
This is really subjective and it is more of a gut feeling (maybe even nostalgia). The Elixir developer community still young (not in terms of developers' ages but in terms of how long it has been established) and comparatively small compared to say the communities who use Python or JavaScript or write iOS apps.  There is definitely a 'we're in this together' spirit and I've contacted a few developers so for to ask them questions about blog posts or conference talks and they have all been incredibly friendly, helpful and supportive.

It reminds me of the Objective-C community I joined in 2008 when I started writing macOS applications and just before the number of Cocoa developers exploded due to iOS. You could email another Cocoa developer and the chances were that you'd get a very helpful reply and often some example code with a note saying something like, 'This is how I do it in my application...'

Large communities aren't a bad thing and having lots of resources such as books, conferences, blog posts and podcasts is incredibly helpful (back in 2008 the Big Nerd Ranch book was really the only starter book for Cocoa developers)  but they can become impersonal and finding the right corner to fit into isn't always easy. In a smaller community the enthusiasts and evangelists fight to give their language or platform a foothold and the community grows organically. It's an exciting and fun thing to be a part of.

## Conclusion
It is probably a good thing that I limited myself to five items because the list could go on and on. I agonised about what to include in the list and what to leave out but I think I've picked a reasonable mix of things to give you a flavour of what makes Elixir a fun and exciting language.

However this isn't just about Elixir. If you've been a developer for more than a few years and you've only focused on one language or platform then it is worth taking a look at what else is out there. You don't have to change your day job or do anything dramatic but it might at least give you some fresh insights into how you can change and improve your own code as well as giving you an idea of how other languages may be better (or worse) than the one you are currently focusing on. Don't stagnate.
