---
date: 2019-07-27 14:30
title: Functional Programming (Over?) Simplified
categories: [software development]
tags: [elixir]
---

## Introduction

Since changing track from being a macOS application developer to being an Elixir developer a few people have asked me about functional programming and how it is different to object-orientated programming. This is my answer, written from the perspective of an Elixir programmer rather than being an exact, academic definition.

## In One Sentence

> Functional programming is when functions transform data in a safe, predictable way.

## The Details

The three elements of my definition can be expanded into three concepts; separation, immutability, and purity.

### Separation

The functions which transform the data are completely separate from the data. If you want to convert a string to uppercase you would use the `upcase` function in the `String` module like this:

`String.upcase("elixir")`

Compare this to object-orientated code where you would have a string object (the data) and then invoke a method which is defined as part of the object's class:

`"elixir".uppercased()`

You might be thinking that things just looked flipped around so a clearer example might be when you want to pad the start of a string:

`String.pad_leading("15.25", 8, " ")`

The result of this is `"   15.25"`.

Note that you have to pass the `pad_leading` function in the `String` module the string you want to pad, the length of the string you want and what you want to use for padding (spaces in this example). The `leading` function knows nothing about the `15.25` string and the `15.25` string knows nothing about the `pad_leading` function.

### Immutability

In functional programming data is immutable. Once it has been created it cannot be changed (and in some functional languages you cannot even re-assign the value of a variable to further re-inforce this).

In an object-orientated language you might have an instance of an object such as a car and you can change the colour of that object. You are simply updating a property. The object is mutable.

In a functional programming language you obviously cannot have a car object but you could have a data structure instead:

`my_car = %{colour: "red", built: 2019}`

Now we can replace the value of `colour` with "green":

`Map.replace!(my_car, :colour, "green")`

However because we did not assign the result of the `replace!` function back to the `my_car` variable, `my_car` is unchanged.

Similarly, because data is not an object, changing the value in one item of data does not affect a copy of the data:

```
my_car = %{colour: "red", built: 2019}
-> %{built: 2019, colour: "red"}
your_car = my_car                              
-> %{built: 2019, colour: "red"}
my_car = Map.replace!(my_car, :colour, "green")
-> %{built: 2019, colour: "green"}
my_car                                         
-> %{built: 2019, colour: "green"}
your_car                                       
-> %{built: 2019, colour: "red"}
```

### Purity

In functional programming the return value from a function is only dependent on the input. If you input the same values over and over again you will always get the same results. When this is the case the function is called a pure function.

Pure functions make functional programming predictable. Because data and functions are separate and because data is immutable it is not possible for an external factor to impact on the code running inside a function.

> **NOTE**  
> Impure functions do exist and do have side effects which can impact on the results of a function. For example, retrieving data from a database could fail which will impact on the output of the function. There are various ways to handle these but the important thing is to know that the exist, are recognised and can be handled.

## That's It

And really that's the core of what makes up functional programming: functions separate from data, data being immutable, and functions being pure (as far as possible).

## Except For...

When people talk about functional programming they often launch into talking about `map`, `reduce`, `filter` and other similar terms. There are just functions which return data from data. However, unlike other examples given above they accept functions as parameters.

Functions are also data. This doesn't contradict the idea that functions and data are separate, rather it means that functions can be passed into other functions to affect how they process data.

Let's look at an example based around a list of numbers:

`numbers = [1, 2, 3, 4, 5]`

The `Enum` module in Elixir contains a `count` function which can be used to count the number of items in a list:

```
Enum.count(numbers)
-> 5
```

It also contains a variation on this function where you can pass it a list and a function. This only counts list items where they are true when run through the function.

So, if the function checked for even values then the the result should be `2` because there are only two even numbers in the `numbers` list.

Do not worry about the actual syntax but the `is_even` variable below is being set to a function which accepts a number and returns whether it is odd or even. Note that the function is being assigned to `is_even`, not the result of the function but the function itself.

`is_even = fn number -> rem(number, 2) == 0 end`

The `count` function is passed the list of numbers and the function and it loops through the list of numbers, passes each on into our `is_even` function and only counts those which are even.

```
Enum.count(numbers, is_even)
-> 2
```

More usually you will see the `is_even` function in-lined and which shorter variable names:

```
Enum.count(numbers, fn x -> rem(x, 2) == 0 end)
-> 2
```

## Conclusion

Hopefully some of the mystery of functional programming has now been dispelled and the fact that it is straightforward and logical is clearer. There are obviously programming patterns which help functional programmers write applications but really the concept itself is as simple as this blog post has hopefully shown.

**Thanks**  
My thanks to [Daniel Steinberg](https://dimsumthinking.com) ([@dimsumthinking](https://twitter.com/dimsumthinking)) for comments and feedback about drafts of this post.
