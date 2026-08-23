ejercicio3: ejercicio3.y ejercicio3.l
	bison -d ejercicio3.y
	flex ejercicio3.l
	gcc -o ejercicio3 ejercicio3.tab.c lex.yy.c -lfl

clean:
	rm -f ejercicio3 ejercicio3.tab.c ejercicio3.tab.h lex.yy.c
