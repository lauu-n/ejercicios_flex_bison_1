%{
/*
 * ej_2.y
 *
 * Gramática (bison) para la calculadora del libro "flex & bison".
 * Ejercicio 2 del capítulo 1: el resultado se imprime en hexadecimal.
 */
#include <stdio.h>

int yylex(void);
void yyerror(char *);
%}

%token NUMBER
%token ADD SUB MUL DIV ABS OP CP EOL

%%

/* Una lista de líneas, cada una con una expresión o vacía */
calclist: /* vacío */
        | calclist exp EOL {
              /* Se imprime el resultado en hexadecimal (%#x agrega
               * el prefijo 0x) */
              printf("= %#x\n", $2);
          }
        | calclist EOL   /* línea vacía, no hace nada */
        ;

exp: factor
   | exp ADD factor { $$ = $1 + $3; }
   | exp SUB factor { $$ = $1 - $3; }
   ;

factor: term
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term {
            if ($3 == 0) {
                yyerror("no se puede dividir entre cero");
                $$ = 0;
            } else {
                $$ = $1 / $3;
            }
        }
      ;

term: NUMBER
    | ABS term    { $$ = $2 >= 0 ? $2 : -$2; }
    | OP exp CP   { $$ = $2; }
    ;

%%

int main(int argc, char **argv)
{
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
