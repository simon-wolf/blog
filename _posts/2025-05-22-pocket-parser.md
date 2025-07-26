---
date: 2025-05-22 12:00
title: Pocket Parser
categories: [programming]
tags: [awk]
---

Earlier today I received an email telling me that Mozilla was [shutting down Pocket](https://support.mozilla.org/en-US/kb/future-of-pocket), a service which allowed you to save links to web pages you wanted to read later.

They have a data export facility so I could get a copy of the data I had stored and, after downloading the file, I realised it was a very simple CSV file containing the page title, the URL, when it was saved, the category(s) assigned to it and the read state.

Because it seemed oddly popular [last time I wrote about it](2025-03-26-counting-the-cost), I decided to parse the file in AWK and generate a simple Markdown file containing the links, grouped by the category.

## The Output I Wanted

One of the joys of getting older is the lack of guilt about becoming more regressive in my approach to technology and I'm using plain text file formats more and more as I realise the value of "owning" my own data. I'm not sure if it is a realistic long-term solution but my immediate thought was to simply store the data I had added to Pocket in a single Markdown file which listed the links in groups based on the category:

```markdown
# Category

* [Page Title](URL) on Date
```

## The Source Data

As mentioned above, the export from Pocket is remarkably straightforward, and shows how a fairly complex service for grabbing page information via browser plugins and then allowing the pages to be managed and reviewed in smartphone apps and a web application essentially boils down to five field in CSV file.

The first line of the file contains the column or field headings and then each line after that contains the details for a page:

```markdown
title,url,time_added,tags,status
Pocket,https://getpocket.com/home,1661766509,,unread
```

## Considerations

There were a few things I needed to take account of before digging into my AWK script:

1. CSV files can contain commas inside fields and whilst the CSV format handles that by wrapping the field in quotes, AWK would just react to the commas and treat them as delimiters.
2. The script needed to ignore the first line in the file which contains the heading information.
3. The data and time when the file was saved are UNIX timestamps (the number of seconds since 1 January 1970 in UTC) and would need to be converted into something readable.
4. The data the category, if one exists, is all lowercase. The category name would ideally have the initial character turned into uppercase.

## CSV File Handling

This is where I was lucky. For the first 46 years of AWK this would involve using a third-party solution or creating my own. But [in 2023 CSV support](https://www.gnu.org/software/gawk/manual/html_node/Comma-Separated-Fields.html) was added to AWK and gawk.

Parsing a CSV file is now as easy as invoking AWK with either the `-k` or `--csv` options. And this also automatically sets the delimiter to a comma.

`awk --csv -f pocket_parser.awk pocket-parser-download-data.csv`

## Skipping The First Line

### The `if` Block

> The initial version of the blog post wrapped everything in an `if` block:

The first line of the file can be skipped by only parsing lines where the record (line) number, NR, is greater than one:

```awk
{
    if (NR > 1) {
        ...
    }
}
```

### Using Patterns

[Lke](https://social.sdf.org/@lke) reached out to me via [Mastodon](https://social.sgawolf.com) to ask why I had used an `if` block rather than using patterns which is arguable a saner approach and it allows me to show off another AWK feature.

Patterns allow you to define a 'rule' and if the conditions of the rule are met then the code in the block following it is applied.

As a contrived example, to print "First Line" when the first line of the file is parsed and print "Not The First Line" for all of the other lines, the following would work:

```awk
NR == 1 { print("First Line") }
NR > 1 { print("Not The First Line") }
```

For this job I am only interested in everything but the first line:

```awk
NR > 1 {
    ...
}
```

## Formatting The Date

The date and time when the link was originally saved is stored in the third (`$3`) field and AWK has a [`strftime`](https://www.man7.org/linux/man-pages/man3/strftime.3.html) function which allows UNIX timestamps to be formatted into a string value. I wanted to use a format so that dates and times would be formatted as `2025-05-22 at 15:37:04`:

```awk
NR > 1 {
    formatted_date = strftime("%Y-%m-%d at %H:%M:%S", $3)
    ...
```

## Fixing The Category Name

The category is stored in the fourth (`$4`) field. If a category is not set then I will use "Undefined" just so that there is a reasonable way to group the links.

If there is a category name then I can combine the `toupper` and `tolower` functions with the `substr` function to extract the required parts of the name.

`substr($4,1,1)` gets the first character from the `$4` field. `toupper` will then convert it to uppercase.

`substr($4,2)` gets the second character onwards from the `$4` field. `tolower` will then convert it to lowercase.

```awk
NR > 1 {
    ...
    if ($4 == "") {
        category = "Undefined"
    } else {
        category = toupper(substr($4,1,1)) tolower(substr($4,2))
    }
    ...
```

> This might be very specific to how I used Pocket with single category names and them being all lowercase.

Note that string concatenation in AWK doesn't have an operator, you just write expressions next to each other with no operator. This is why the `toupper` and `tolower` functions can have zero, one or more spaces between them but the output will be "joined":

The following would all result in something like `Example` if the fourth field contained `example`:

```text
toupper(substr($4,1,1))tolower(substr($4,2))
toupper(substr($4,1,1)) tolower(substr($4,2))
toupper(substr($4,1,1))       tolower(substr($4,2))
```

## Collating The Data

Now that the page title, URL, formatted date and category have been gathered I needed to store the Markdown formatted version of it all. I am going to show the URLs as a bullet list so there is an asterisk at the start of each line. I also need to add a newline (`/n`) at the end of each entry too.

In Markdown the links look like this:

```markdown
* [A Page Title](https://page_url.html) on 2025-05-23 at 15:37:04
```

In AWK, using field references and the `formatted_date` variable we created it looks like:

```awk
"* [" $1 "](" $2 ") on " formatted_date "\n"
```

The page links need to be stored in an 'array', which I called `arr`. This is an array subscript (very similar to a map or dictionary in other languages) where the category names are used as the subscript:

```awk
    arr[category]=...
```

The value stored against each subscript is just a string which contains the Markdown for each page link.

```awk
    ...
    arr[category] = arr[category] "* [" $1 "](" $2 ") on " formatted_date "\n"
    ...
```

## Eh?

Just in case that's not entirely clear, a less convoluted example of what is going on can be created from a list of pets:

```text
cat,Binky
cat,Mr Tibbles
dog,Fido
cat,Slippers
dog,Bruno
dog,Shep
```

In each record `$1` is the animal type and `$2` is the pet's name.

The idea is to end up with an array of animal types which each containin a string of names, each on their own line:

```text
cat = "Binky
       Mr Tibbles
       Slippers"
dog = "Fido
       Bruno
       Shep"
```

To create this, a simplified version of the code from above is:

```awk
    ...
    arr[$1] = arr[$1] $2 "\n"
    ...
```

And the `arr` variable would end up containing:

```awk
arr["cat"]="Binky\nMr Tibbles\nSlippers\n"
arr["dog"]="Fido\nBruno\nShep\n"
```

### Step-by-Step

The step-by-step process is as follows...

1. `arr` is empty.

2. The first record is "cat,Binky". `$1` is "cat" and `$2` is "Binky".

`arr["cat"]` does not exist so `arr[$1] = arr[$1] $2 "\n"` is concatenating `""` with `Binky` and `\n` and then storing that against `arr["cat"]`.

```text
arr["cat"]="Binky\n"
```

3. The second record is "cat,Mr Tibbles". `arr["cat"]` does exist so this time the existing data is concatenated with the new data: `Binky\n` is concatenated with `Mr Tibbles` and `\n` and then stored against `arr["cat"]`.

```text
arr["cat"]="Binky\nMr Tibbles\n"
```

4. The third record is "dog,Fido". `arr["dog"]` does not exist so we concatenate `""` with `Fido` and `\n` and store it against `arr["dog"]`.

```text
arr["cat"]="Binky\nMr Tibbles\n"
arr["dog"]="Fido\n"
```

And so on...

## Outputting The Markdown

The Markdown file I want to generate should contain the category headings and a list of the links below it:

```markdown
# Category One

* Link One
* Link Two

# Category Two

* Link Three
* Link Four
...
```

This output is generated in an `END` block in AWK since the output is only generated once all of the file's lines have been parsed, not as each is parsed.

```awk
END {
    for (a in arr)
        printf "# %s\n\n%s\n", a, arr[a]
}
```

This will be clearer using the cat and dog data. The data has been tweaked from the earlier example to add an asterisk before each pet's name so that the Markdown would be formatted as a bulleted list:

```text
arr["cat"]="* Binky\n* Mr Tibbles\n* Slippers"
arr["dog"]="* Fido\n* Bruno\n* Shep"
```

The code loops through each "grouping name" ("cat" and "dog") in `arr`.

For each grouping name it will output `# `, the grouping name, two newlines (`\n\n`) the text stored in the grouping, and then a final newline.

Replacing the newline characters makes this a bit clearer:

```text
# [Grouping Name]

[Grouping Contents]

```

The end result would be:

```text
# Cat

* Binky
* Mr Tibbles
* Slippers

# Dog

* Fido
* Bruno
* Shep

```

## The Complete Script

```awk
NR > 1 {
    formatted_date = strftime("%Y-%m-%d at %H:%M:%S", $3)

    if ($4 == "") {
        category = "Undefined"
    } else {
        category = toupper(substr($4,1,1)) tolower(substr($4,2))
    }

    arr[category] = arr[category] "* [" $1 "](" $2 ") on " formatted_date "\n"
}
END {
    for (a in arr)
        printf "# %s\n\n%s\n", a, arr[a]
}
```

## Checking It Out

The script is available for download as [pocket-parser.awk]({{ site.url }}/downloads/pocket-parser.awk) and a sample data file as [pocket-parser-download-data.csv]({{ site.url }}/downloads/pocket-parser-download-data.csv). An example of the output is available as [pocket-parser-output.md]({{ site.url }}/downloads/pocket-parser-output.md).

You can run the script yourself via `awk --csv -f pocket_parser.awk pocket-parser-download-data.csv > pocket-parser-output.md`.

