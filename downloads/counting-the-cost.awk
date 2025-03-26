# awk -f shopping-summary.awk 2025-03-28-how-much-is-my-health-worth.md

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
END {
  {
	  for (a in arr)
		  printf "%s: £%'.2f\n", a, arr[a]
  }

  print ""
  printf "Grand Total: £%'.2f\n", sum
}
