
# Makefile para la calculadora hexadecimal (flex + bison)
# Ejercicio 2, Capítulo 1 del libro "flex & bison"

ej_2: ej_2.l ej_2.y
	bison -d ej_2.y
	flex ej_2.l
	cc -o ej_2 ej_2.tab.c lex.yy.c -lfl

clean:
	rm -f ej_2 ej_2.tab.c ej_2.tab.h lex.yy.c