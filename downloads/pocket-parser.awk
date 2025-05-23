# Parse a Pocket export to create a Markdown file with links in it, grouped into sections by tags.
#
# The fields in the Pocket export are:
# [Title],[URL],[Time Added],[Tags],[Status]
#
# We need to skip the first row which contains the names.
#
# The script can be run via a command such as:
# awk --csv -f pocket_parser.awk part_000000.csv > pocket.md

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
