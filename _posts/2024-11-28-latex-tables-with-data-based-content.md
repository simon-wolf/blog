---
date: 2024-11-28 08:00
title: LaTeX Tables With Data-Based Content
categories: latex
---

I have been simplifying and standardising the [LaTeX](https://www.latex-project.org/) files used to generate my company's policies and agreements. This has included using some easily editable 'metadata' at the start of each document and I wanted to be able to manage the changelog contents there too.

I did find some solutions on [TeX StackExchange] and several use[`expl3`](https://ctan.org/pkg/expl3) which I just found incomprehensible (but have added to my to-do list to dig into).

There were some solutions suggested which use the [`listofitems`](https://ctan.org/pkg/listofitems) package and I put together my solution using that and managed to solve my problem of wanting to use `\toprule`, `\midrule` and `\bottomrule`.

> A (Basic) Note About Terminology
>
> LaTeX commands are TeX macros. This means that `\newcommand` is a macro. In this post I will be referring to macros rather than commands.
>
> The [Overleaf](https://www.overleaf.com) support area contains [a multi-part explainer](https://www.overleaf.com/learn/latex/How_TeX_macros_actually_work%3A_Part_1) about macros which is a very good read if you are feeling adventurous.

## A Basic Minimal Example

```latex
\documentclass{article}

\usepackage{listofitems}

% empty macro to be extended by individual table rows
\newcommand{\itemrows}{}

% function to take a single nested table and iteratively extend the above macro with the table's contents
\makeatletter
\newcommand{\itemstablecontents}[1]{
  \setsepchar{;}
  \readlist*\itemlist{#1}
  \foreachitem \item \in \itemlist[]{
    \setsepchar{,}
    \readlist*\changeinfo{\item}

    \expanded{
      \noexpand\g@addto@macro\noexpand\itemrows{
        \changeinfo[1] & \changeinfo[2] \\
      }
    }
  }
}
\makeatother

\begin{document}
  Before The Changelog

  \section*{Changelog}

  \itemstablecontents{
    1 Aug 2024, Initial version.;
    21 Sept 2024, Fixed some bugs.;
    7 Dec 2024, Added a feature.
  }

  \begin{tabular}{ l l }
    \itemrows
  \end{tabular}

  After The Changelog
\end{document}
```

The macro `\itemstablecontents` is passed the contents for the table and below you can see the sample data used:

```latex
\itemstablecontents{
  1 Aug 2024, Initial version.;
  21 Sept 2024, Fixed some bugs.;
  7 Dec 2024, Added a feature.
}
```

The row items are delimited by commas and the rows themselves are delimited by semicolons.

`itemstablecontents` populates a macro called `itemrows` with the actual data formatted as it should be to display in a table. This means that `\itemrows` can just be used in the document where the table should appear.

The `itemstablecontents` macro does the following:

1. Reads the table data into a list called `itemlist`. The list items are delimited by the semicolon character.
2. Parse each `item` and split it using the comma character. The resulting items are stored in `changeinfo` and they can be referenced by their index. The date can be referenced via `changeinfo[1]` and the description via `changeinfo[2]`.
3. Add the changelog entry data to the `itemrows` macro in the format we need for a table row (columns are separated by an `&` and rows are terminated by `\\`).

## A More Polished Example

I made a few changes for my final version which do the following:

1. Move the changelog data to the top of the file (in the actual documents the preamble is in a separate file which makes this make more sense).
2. Use `::` as the elements separator and `:::` as the row separator. I find this more readable.
3. Use [tabularx](https://ctan.org/pkg/tabularx) and [booktabs](https://ctan.org/pkg/booktabs) for a prettier table.
4. Use [parskip](https://ctan.org/pkg/parskip) so that paragraphs are not indented and have space between them.
5. As well as adding the data to each table row, a check is performed to see if the item's index (`itemcnt`) is the same as the number of items (`itemrows`) and if not then a `\midrule` is added. The last item does not need a `\midrule` because the table has a `\bottomrule` at the end.

```latex
\newcommand{\changelog}{
  1 Aug 2024 :: Initial version. :::
  21 Sept 2024 :: Fixed some bugs. :::
  7 Dec 2024 :: Added a feature.
}

\documentclass{article}

\usepackage{listofitems}

\usepackage{tabularx}
\usepackage{booktabs}

% Begin paragraphs with an empty line rather than an indent
\usepackage[]{parskip}

% empty macro to be extended by individual table rows
\newcommand{\itemrows}{}

% function to take a single nested table and iteratively extend the above macro with the table's contents
\makeatletter
\newcommand{\itemstablecontents}[1]{
  \setsepchar{:::}
  \readlist*\itemlist{#1}
  \foreachitem \item \in \itemlist[]{
    \setsepchar{::}
    \readlist*\changeinfo{\item}

    \expanded{
      \noexpand\g@addto@macro\noexpand\itemrows{
        \changeinfo[1] & \changeinfo[2] \\
      }
    }

    % check if we need a midrule
    \ifnumequal{\itemcnt}{\itemlistlen}{
      % do nothing... this is the last row
    }{
      \g@addto@macro\itemrows{
        \midrule
      }
    }
  }
}
\makeatother

\begin{document}
  Before The Changelog

  \subsection*{Changelog}

  \itemstablecontents{\changelog}

  \begin{table}[h!]
    \begin{tabularx}{\textwidth}{l X}
      \toprule
      \textbf{Date} & \textbf{Changes} \\
      \toprule

      \itemrows

      \bottomrule
    \end{tabularx}
  \end{table}

  After The Changelog
\end{document}
```

## Macro Manipulation

> This section of the post digs a little deeper into how this works and is not necessary to read or understand if you just want a solution that works.

The core of the above solution is that we start with an empty macro (`\newcommand{\itemrows}{}` and then "push" content into it so that by the time it is invoked its actual definition is more like:

```latex
\newcommand{\itemrows}{
  1 Aug 2024 & Initial version. \\
  \midrule
  21 Sept 2024 & Fixed some bugs. \\
  \midrule
  7 Dec 2024 & Added a feature. \\
}
```

This is done in the `itemstablecontents` macro which itself is is wrapped by the `makeatletter` and `makeatother` macros and includes the `expanded` and `noexpand` macros. We also use the `g@addto@macro` macro to "push" content into the `itemrows` macro.

Without getting into the whole area of catcodes and how Tex and, by extension LaTeX, parses the characters in a `tex` file (this is done in the Overleaf article linked to at the top of this post), just know that to be able to use the `g@addto@macro`, which is an internal LaTeX macro, we need to change how the `@` character is parsed by LaTeX. `@` is not allowed to occur in the name of a TeX or LaTeX macro and names are made up of uppercase and lowercase letters. `@` is classified as "other" rather than "letter" so we need to tell LaTeX to treat the `@` character as a "letter". This is done via the `makeatletter` macro and to tell LaTeX to treat `@` as "other" again, the `makeatother` macro. These top-and-tail the whole `itemstablecontents` macro because we need to let LaTeX parse the macro as a whole rather than just being able to change how `@` is handled within part of it.

The `expanded` and `noexpand` macros are used to manage what is pushed into the `itemrows` macro. In the `itemstablecontents` macro we are looping through the changelog lines and splitting the contents into two elements, `changeinfo[1]` and `changeinfo[2]`. We are then adding those elements, along with an `&` to separate the columns and an `\\` to denote the end of the row, to the `itemrows` macro.

Key to this is that `changeinfo` is a macro and a naive approach such as the one below will simply fill `itemrows` with references to the macro itself:

```latex
\g@addto@macro\itemrows{
  \changeinfo[1] & \changeinfo[2] \\
}
```

The `itemrows` macro would end up as:

```latex
\changeinfo[1] & \changeinfo[2] \\
\midrule
\changeinfo[1] & \changeinfo[2] \\
\midrule
\changeinfo[1] & \changeinfo[2] \\
```

When it is parsed, all three rows would end up showing the same data because they are just going to use the current values of `changeinfo[1]` and `changeinfo[2]` and not the values as they were when each row was added.

To get the values we need to run, or expand, the `changeinfo` macro for each item in each row so that the resulting value can be added to the rows in `changeinfo`.

The first idea might be to expand `changeinfo` in each row:

```latex
\g@addto@macro\itemrows{
  \expandafter\changeinfo[1] & \expandafter\changeinfo[2] \\
}
```

The problem with this is that `g@addto@macro` is 'capturing' the whole line and storing it so the expansion is not going to happen as each row is added, it will rather be done when the final `itemrows` macro is expanded which is still too late and results in the same problem of the last entry being shown for every row.

The solution is to flip things around so that we create a 'block' will which be expanded as we loop through the changelog rows:

```latex
\expanded{
  g@addto@macro\itemrows{
    \changeinfo[1] & \changeinfo[2] \\
  }
}
```

But this doesn't work either since LaTeX will attempt to expand `g@addto@macro` and `itemrows` which is not possible at this point and results in the 'tex' document being unparsable.

So the solution to it all is to expand the block but not the macros within it that we need to reference, not have the results of:

```latex
\expanded{
  \noexpand\g@addto@macro\noexpand\itemrows{
    \changeinfo[1] & \changeinfo[2] \\
  }
}
```

And finally, because adding a `midrule` does not involve expanding a macro to get a value it is simply:

```latex
\g@addto@macro\itemrows{
  \midrule
}
```

