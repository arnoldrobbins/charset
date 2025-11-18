#! /usr/bin/gawk -f

BEGIN { printf("%c\n", strtonum(ARGV[1])) }
