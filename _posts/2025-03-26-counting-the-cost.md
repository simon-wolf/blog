---
date: 2025-03-26 18:00
title: Counting The Cost
categories: linux
---

In my [previous blog post](2025-03-26-how-much-is-my-health-worth) I included a table of purchases related to some lifestyle changes I have been making. As a typical software developer it would have been far too easy to use a calculator to add the amounts up. It would have been too easy to paste the data into a spreadsheet. Instead I spent a ridiculous amount of time tinkering with [AWK](https://en.wikipedia.org/wiki/AWK). And then, very proud of myself, I [posted about it](https://social.sgawolf.com/@simon/114225914932716482) on Mastodon, saying that the two hours were worth it because I could write a blog post about it:

![image tooltip here](/images/2025-03-26-counting-the-cost-01.jpeg)

Well this is that blog post.

## The Problem Being Solved

In the previous blog post I included a Markdown table which contained three columns. A pruned version of it is reproduced below:

| Item | Cost | Category |
| --- | --: | :-: |
| Digital Scales | £22.94 | Weight Loss |
| Zwift Ride and Kickr Core | £1,080.00 | Cycling |
| Zwift Training Mat | £79.99 | Cycling |
| Zwift Tablet Holder | £39.99 | Cycling |
| Zwift Subscription | £179.99 | Cycling |
| Running Shoes | £140.00 | Running |
| Running Socks | £19.95 | Running |
| Running Shorts* | £30.00 | Running |
| Running Tops* | £30.00 | Running |
| Sports Watch | £609.00 | Luxury |

I wanted to use AWK to find the table in the post and then to total up the amounts, both by category and also to generate a grand total.

## Finding The Data

AWK will parse every line passed to it for processing so I needed to find the table in amongst all of the other text in the post.

The "raw" table looks like this in Markdown:

```markdown
| Item | Cost | Category |
| --- | --: | :-: |
| Digital Scales | £22.94 | Weight Loss |
| Zwift Ride and Kickr Core | £1,080.00 | Cycling |
| Zwift Training Mat | £79.99 | Cycling |
| Zwift Tablet Holder | £39.99 | Cycling |
| Zwift Subscription | £179.99 | Cycling |
| Running Shoes | £140.00 | Running |
| Running Socks | £19.95 | Running |
| Running Shorts* | £30.00 | Running |
| Running Tops* | £30.00 | Running |
| Sports Watch | £609.00 | Luxury |
```

Fortunately the post only contained one three-column table so I could set the field separator to be the pipe character and then look for lines where there were five fields:

```awk
FS = "|";

if (NF == 5) {
    .... 
}
```

But if it is a three-column table why look for five fields? It's because the two pipes on the outside of the table are acting as delimiters so AWK assumes that there is a field before and after them. It's easier to visualse if it looks like this:

```awk
.. | Digital Scales | £22.94 | Weight Loss | ..
```

## Extracting The Data Elements

Within each record we want to work with fields 2, 3, and 4 (1 and 5 are the empty 'outer' ones).

Because of the way Markdown tables are defined, each field value has spaces around it:

```awk
" Digital Scales ", " £22.94 ", and " Weight Loss "
```

Sadly AWK doesn't have a handy `trim` function but we can write our own which uses regex to find whitespace at the start of the string and remove it and then find whitespace at the end of the string and remove it:

```awk
function trimfield(value)
{
    sub(/^\s*/, "", value)
    sub(/\s$/, "", value)
    return value
}
```

Dealing with the currency amounts is a bit more complex because, as well as stripping the whitespace we need to remove the currency symbol and any thousands delimiters:

```awk
function stripcurrency(value)
{
      sub(/£/, "", value);
      gsub(/,/, "", value);
      return trimfield(value); 
}
```

> Note the use of `gsub` for removing the thousands delimiter. If the numbers were large enough there might be more than one delimiter to remove.

This again uses regex to remove the characters and the function also passes the results to our `trimfield` function to remove the whitespace.

This means that we can pass the value of each field into the `trimfield` or the `stripcurrency` functions to get 'clean' data back:

```awk
"Digital Scales", "22.94", and "Weight Loss"
```

## Handling The Headers

We don't want to include the first two table rows in our scan:

```markdown
| Item | Cost | Category |
| --- | --: | :-: |
```

The easiest way to do this is to check if field 3 (the Cost column) is a number or not. If it is not then we can ignore the record:

```awk
itemvalue = stripcurrency($3)

if (itemvalue+0 != 0) {
    ...
}
```

> $3 is AWK's way of referencing field 3 so we pass the value of field 3 (the Cost column) into the `stripcurrency` function and store it in a variable called `itemvalue`.

If we add zero to a number we get the original number. But if we add zero to something which is not a number we get `0`. We can therefore see if the field value is a number because it would be non-zero.

> Obviously if the number is zero then adding zero returns zero but then there is nothing to increment our totals in that case so it is a non-issue.

So we now have a way to loop through the file, find lines which are part of the Markdown table, extract the contents into usable values and test if the line should be used in our totals:

```awk
if (NF == 5) {
    item = trimfield($2)
    itemvalue = stripcurrency($3)
    category = trimfield($4)

    if (itemvalue+0 != 0) {
        ...
    }
}
```

## Grouping By The Category And Summing The Total

We use two variables, `arr` and `sum` to store an array of category totals and the overall total.

The implementation is pretty simple:

```awk
arr[category] += itemvalue;
sum += itemvalue;
```

> `arr[category]` may look like how some languages define maps or dictionaries but here it is an array subscript.

## Showing The Results

To show the results we loop through the array and how each element and its value (formatted to two decimal places):

```awk
for (a in arr)
    printf "%s: £%'.2f\n", a, arr[a]
```

And then we show the grand total:

```awk
printf "Grand Total: £%'.2f\n", sum
```

## The Complete Script

```awk
function trimfield(value)
{
    sub(/^\s*/, "", value)
    sub(/\s$/, "", value)
    return value
}

function stripcurrency(value)
{
    sub(/£/, "", value);
    gsub(/,/, "", value);
    return trimfield(value); 
}

{
    FS = "|";

    if (NF == 5) {
        item = trimfield($2)
        itemvalue = stripcurrency($3)
        category = trimfield($4)

        if (itemvalue+0 != 0) {
            arr[category] += itemvalue;
            sum += itemvalue;
        }
    }
}
END
{
    {
        for (a in arr)
            printf "%s: £%'.2f\n", a, arr[a]
    }

    print ""
    printf "Grand Total: £%'.2f\n", sum
}
```

## Checking It Out

The script is available for download as [counting-the-cost.awk]({{ site.url }}/downloads/counting-the-cost.awk) and a sample data file as [counting-the-cost-data.txt]({{ site.url }}/downloads/counting-the-cost-data.txt).

If you run the script via `awk -f counting-the-cost.awk counting-the-cost-data.txt` you'll see the following output:

```
Luxury: £609.00
Running: £219.95
Cycling: £1,379.97
Weight Loss: £22.94

Grand Total: £2,231.86
```

