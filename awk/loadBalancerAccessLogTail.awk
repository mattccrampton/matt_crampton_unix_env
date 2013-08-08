
function colorizeWord(word, color){
	c["red"] = "[1;31;40m"
	c["green"] = "[1;32;40m"
	c["yellow"] = "[1;33;40m"
	c["blue"] = "[1;34;40m"
	c["magenta"] = "[1;35;40m"

	return c[color] (word) "[0;37;40m"
}

{
#line = $0
lastW = lastw
#lastW = 5

http_status = $9
if ( http_status != "200" &&
        http_status != "\"-\"" &&
        http_status != "301" &&
        http_status != "302" &&
        http_status != "499" &&
        http_status != "304" )
{
	line = sprintf("%-16s %-6s %-6s %-30s %s", $1, $6, http_status, substr($7,0,30), substr("!!!!!!!!!!!!!!!!!!!!!!!!",0,lastW))
        line = colorizeWord(line, "red")
} else {
	if($7 == "/v5/submitDataForPictureTask"){
		line = sprintf("%-16s %-6s %-6s %-30s WORKED", $1, $6, http_status, substr($7,0,30))
		line = colorizeWord(line, "yellow")
	} else {
		line = sprintf("%-16s %-6s %-6s %-30s %s", $1, $6, http_status, substr($7,0,30), substr($11,0,lastW))
		line = colorizeWord(line, "green")
	}
}
print line

fflush()
}



