# Makefile for charset doc and code

CFLAGS = -g

TWJRSOURCE = charset.twjr

SOURCE = charset.h charset.c

OBJ = charset.o

DOC = charset.texi

PDF = charset.pdf

all: $(PDF) btest genranges

$(PDF): $(DOC) texinfo.tex
	texi2pdf $(DOC)

$(DOC): $(TWJRSOURCE)
	./jrweave $(TWJRSOURCE) > $(DOC)

$(OBJ): $(SOURCE)

btest.o: btest.c

btest.c: $(TWJRSOURCE)
	./jrtangle $(TWJRSOURCE)

btest: $(OBJ) btest.o
	gcc $(CFLAGS) $(OBJ) btest.o -o btest

genranges.o: genranges.c

genranges.c: $(TWJRSOURCE)
	./jrtangle $(TWJRSOURCE)

genranges: $(OBJ) genranges.o
	gcc $(CFLAGS) $(OBJ) genranges.o -o genranges

$(SOURCE): $(TWJRSOURCE)
	./jrtangle $(TWJRSOURCE)

clean:
	rm -f *.[cho] charset.?? charset.??? charset.texi btest runtests.sh

spell:
	spell $(TWJRSOURCE) | LC_ALL=C sort -u | LC_ALL=C comm -23 - wordlist

check: btest
	./runtests.sh > _tests ; \
	if cmp -s tests.good _tests ; \
	then	rm _tests; \
	else	diff -u tests.good _tests | more ; \
	fi
