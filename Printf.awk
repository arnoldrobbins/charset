#! /usr/bin/gawk -f

BEGIN {
	for (i = 1; i < ARGC; i++)
		printf("%c\n", strtonum(ARGV[i]))
}
