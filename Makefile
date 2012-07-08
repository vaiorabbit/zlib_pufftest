all: inflate
clean:
	rm inflate.o puff.o inflate

inflate: inflate.o puff.o
	g++ puff.o inflate.o -O2 -o inflate # -lz
inflate.o: inflate.cpp puff.c puff.h

puff: puff.o
	gcc puff.o -O2 -o puff
puff.o: puff.c puff.h

.o.cpp: inflate.cpp puff.c
