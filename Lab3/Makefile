bin/program: bin/obj/main.o bin/obj/morseTable.o bin/obj/parsers.o bin/obj/translation.o
	gcc -o bin/program bin/obj/main.o bin/obj/morseTable.o bin/obj/parsers.o bin/obj/translation.o

bin/obj/main.o: main.c
	gcc -c -o  bin/obj/main.o main.c

bin/obj/morseTable.o: morseTable.c
	gcc -c -o bin/obj/morseTable.o morseTable.c

bin/obj/parsers.o: parsers.c
	gcc -c -o bin/obj/parsers.o parsers.c

bin/obj/translation.o: translation.c
	gcc -c -o bin/obj/translation.o translation.c