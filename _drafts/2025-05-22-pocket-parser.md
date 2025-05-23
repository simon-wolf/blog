---
date: 2025-05-22 12:00
title: Pocket Parser
categories: linux
---

Earlier today I received an email telling me that Mozilla was [shutting down Pocket](https://support.mozilla.org/en-US/kb/future-of-pocket), a service which allowed you to save links to web pages you wanted to read later.

They have a data export facility so I could get a copy of the data I had stored and, after downloading the file, I realised it was a very simple CSV file containing the page title, the URL, when it was saved, the category(s) assigned to it and the read state.

> I'm unclear about the category field because all of my saved URLs either have one or no category name so I am not sure if you could assign multiple values. If you could then adapting the script below should be pretty simple however.

Because it seemed oddly popular [last time I wrote about it](2025-03-26-counting-the-cost), I decided to parse the file in AWK and generate a simple Markdown file containing the links, grouped by the category.

## The Output I Wanted

One of the joys of getting older is the lack of guilt about becoming more curmudgeonly and I'm using plain text file formats more and more as I realise the value of "owning" my own data. I'm not sure if it is a realistic long-term solution but my immediate thought was to simply store the data I had added to Pocket in a single Markdown file which listed the links in groups based on the category:

```markdown
# Category

* [Page Title](URL) on Date
```

## The Source Data

As mentioned above, the export from Pocket is remarkably straightforward... It just shows how a fairly complex service for grabbing page information via browser plugins and then allowing the pages to be managed and reviewed in smartphone apps and a web application essentially boils down to five field in CSV file.

The first line of the file contains the column or field headings and then each line after that contains the details for a page:

```markdown
title,url,time_added,tags,status
Pocket,https://getpocket.com/home,1661766509,,unread
```

## Considerations

There were a few things I needed to take account of or handle before digging into my AWK script:

1. CSV files can contain commas inside fields and whilst the CSV format handles that by wrapping the field in quotes, AWK would just react to the commas and treat them as delimiters.
2. The script needed to ignore the first line in the file which contains the heading information.
3. The data and time when the file was saved are in UNIX timestamps (the number of seconds since 1 January 1970 in UTC) and would need to be converted into something readable.
4. In my data the category, if one exists, is all lowercase. The category name would ideally need to have the initial character made into uppercase.

## CSV File Handling

The good news is that more recent versions of AWK support a `csv` parameter to handle CSV parsing. The also automatically sets the delimiter to a comma.

`awk --csv -f pocket_parser.awk part_000000.csv > pocket.md`

## Skipping The First Line

The first line of the file can be skipped by only parsing lines where the line number (NR) is greater than one:

```awk
{
    if (NR > 1) {
        ...
    }
}
```

## Formatting The Date

The page title and URL are easy to fetch since they are the first (`$1`) and second (`$2`) fields.

The timestamp from when the link was originally saved is stored in the third (`$3`) field and AWK has a `strftime` function to format a date value:

```awk
{
    if (NR > 1) {
        title = $1
        url = $2
        formatted_date = strftime("%Y-%m-%d at %H:%M:%S", $3)
        ...
```

The `strftime` function is going to format the date as `yyyy-mm-dd at hh:nn:ss` 
which would look like `2025-05-23 at 21:32:15`.

## Fixing The Category Name

The category is stored in the fourth (`$4`) field. If a category is not set then I will use "Undefined" just so that there is a reasonable way to group the links.

If there is a category name then I can combine the `toupper` and `tolower` functions with the `substr` function to extract the required parts of the name.

`substr($4,1,1)` gets the first character from the `$4` field. `toupper` will then convert it to uppercase.

`substr($4,2)` gets the second character onwards from the `$4` field. `tolower` will then convert it to lowercase.

```awk
{
    if (NR > 1) {
        ...
        if ($4 == "") {
            category = "Undefined"
        } else {
            category = toupper(substr($4,1,1)) tolower(substr($4,2))
        }
        ...
```

> As mentioned above, this might be very specific to how I used Pocket with single category names and them being all lowercase.

## Collating The Data

Now that the page title, URL, formatted date and category have been gathered I needed to store the Markdown formatted version of it all. In pure Markdown that would look like:

```markdown
* [A Page Title](https://blog.sgawwolf.com/something.html) on 2025-05-23 at 21:32:15
```

AWK automatically concatenates strings so the actual code needed to generate that would be:

```awk
"* ["title"]("url") on "formatted_date"\n"
```

To make that a bit clearer:

- "* [" = An absolute string (to make this a bullet list item)
- title = The page title
- "](" = An absolute string
- url = The page URL
- ") on " = An absolute string
- formatted_date = The formatted date
- "\n" = An absolute string (to insert a newline)

The page links need to be stored in an array, which I called `arr`, which can group the page links by the category:

```awk
    arr[category]=...
```

> `arr[category]` may look like how some languages define maps or dictionaries but here it is an array subscript.

The value stored in `arr` against the category is any existing links stored against the category with the new one appended to the end:

```awk
    ...
    arr[category]=arr[category]"* ["title"]("url") on "formatted_date"\n"
    ...
```

## Eh?

None of that feels very clear so a less convoluted example of what is going on is below.

A list of pets could be represented as:

```text
cat,Binky
cat,Mr Tibbles
dog,Fido
cat,Slippers
dog,Bruno
dog,Shep
```

The idea is to end up with this sort of structure:

```text
cat = "Binky
       Mr Tibbles
       Slippers"
dog = "Fido
       Bruno
       Shep"
```

`cat` is a single string which each cat's name separated by a newline character. `dog` is the same but for the dog names.

The `arr` variable would therefore essentially contain:

```text
arr["cat"]="Binky
            Mr Tibbles
            Slippers"
arr["dog"]="Fido
            Bruno
            Shep"
```

To turn the original list into that the step-by-step process would be as follows...

1. `arr` is empty.

2. The first record is "cat,Binky" so `arr["cat"]` is set to what was in `arr["cat"]` (nothing) plus `Binky` plus a newline (`\n`).

```text
arr["cat"]="Binky\n"
```

3. The second record is "cat,Mr Tibbles" so `arr["cat"]` is set to what was in `arr["cat"]` (`Binky\n`) plus `Mr Tibbles\n`.

```text
arr["cat"]="Binky\nMr Tibbles\n"
```

4. The third record is "dog,Fido" so `arr["dog"]` is set to what was in `arr["cat"]` (nothing) plus `Fido` plus a newline (`\n`).

```text
arr["cat"]="Binky\nMr Tibbles\n"
arr["dog"]="Fido\n"
```

And so on...

## Outputting The Markdown

To show the Markdown which can eventually be saved to a file I loop through the array and generate a heading for the category name and then output the value stored against it which is :

```markdown
# Category

* Link One
* Link Two
...
```

This is done in an `END` block in AWK since the output is only generated once all of the file lines have been parsed, not as each is parsed.

```awk
END {
    for (a in arr)
        printf "# %s\n\n%s\n", a, arr[a]
}
```

This will be clearer using the cat and dog data. The final state of the data would be:

```text
arr["cat"]="Binky\nMr Tibbles\nSlippers"
arr["dog"]="Fido\nBruno\nShep"
```

The code loops through each "grouping name" ("cat" and "dog") in `arr`.

For each grouping name it will output the grouping name itself and then the contents of the grouping name.

The formatting looks a bit confusing because it is all on one line but if it was expanded it would be:

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
{
    if (NR > 1) {
        title = $1
        url = $2
        formatted_date = strftime("%Y-%m-%d at %H:%M:%S", $3)

        if ($4 == "") {
            category = "Undefined"
        } else {
            category = toupper(substr($4,1,1)) tolower(substr($4,2))
        }

        arr[category]=arr[category]"* ["title"]("url") on "formatted_date"\n"
    }
}
END {
    for (a in arr)
        printf "# %s\n\n%s\n", a, arr[a]
}
```

## Checking It Out

The script is available for download as [pocket-parser.awk]({{ site.url }}/downloads/pocket-parser.awk) and a sample data file as [pocket-parser-download-data.csv]({{ site.url }}/downloads/pocket-parser-download-data.csv). An example of the output is available as [pocket-parser-output.md]({{ site.url }}/downloads/pocket-parser-output.md).

You can run the script yourself via `awk --csv -f pocket_parser.awk pocket-parser-download-data.csv > pocket-parser-output.md`.

