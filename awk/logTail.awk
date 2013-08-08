

function colorize(word, color)
{
c["red"] = "[1;31;40m"
c["green"] = "[1;32;40m"
c["yellow"] = "[1;33;40m"
c["blue"] = "[1;34;40m"
c["magenta"] = "[1;35;40m"
if (line ~ word)
{ split (line, a, word)
line=a[1] c[color] (word) "[0;37;40m" a[2]
}
}
{
line =  substr($0, 0, term_cols)
colorize("PHP Parse error","yellow")
colorize("PHP Fatal error","yellow")
colorize("PHP","yellow")
colorize("Notice","yellow")
colorize("on line","magenta")
colorize("START_REQUEST","blue")
colorize("END_REQUEST","blue")
colorize("successFlag\":true","yellow")
colorize("successFlag\":false","red")

colorize("successFlag\":true","yellow")
colorize("findPinsInRegion","yellow")
colorize("FULL_FIND_GIGS_CACHE_IN_REGION","yellow")
colorize("FULL_CITY_GIG_LIST_CACHE","yellow")
colorize("FULL_FIND_GIGS_CACHE","yellow")

colorize("EMPTY_FIND_GIGS_CACHE_IN_REGION","red")
colorize("EMPTY_CITY_GIG_LIST_CACHE","red")
colorize("EMPTY_FIND_GIGS_CACHE","red")

print line
fflush()
}
