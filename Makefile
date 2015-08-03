
PROG=fizzbuzz

all:
	nasm -f elf64 $(PROG).asm
	gcc -o $(PROG) $(PROG).o
	./fizzbuzz

