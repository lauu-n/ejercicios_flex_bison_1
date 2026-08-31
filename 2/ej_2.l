%{
/*
 * ej_2.l
 *
 * Escáner (flex) para la calculadora del libro "flex & bison".
 * Ejercicio 2 del capítulo 1: soporte para números hexadecimales
 * además de los decimales, y letras como valores (su código ASCII),
 * lo que permite sumar cosas como a+a, b+c, etc.
 */
#include <stdlib.h>
#include "ej_2.tab.h"
void yyerror(char *);
%}
%%
"+"                { return ADD; }
"-"                { return SUB; }
"*"                { return MUL; }
"/"                { return DIV; }
"|"                { return ABS; }
"("                { return OP;  }
")"                { return CP;  }
0x[a-fA-F0-9]+     {
                      /* Número hexadecimal: 0x1A, 0xff, etc.
                       * strtol con base 16 entiende el prefijo "0x"
                       * y convierte el resto directamente. */
                      yylval = strtol(yytext, NULL, 16);
                      return NUMBER;
                   }
[0-9]+             {
                      /* Número decimal normal */
                      yylval = atoi(yytext);
                      return NUMBER;
                   }
[a-zA-Z]           {
                      /* Cualquier letra representa su valor ASCII.
                       * Así 'a' vale 97 (0x61), 'b' vale 98 (0x62), etc.
                       * Esto permite expresiones como a+a, b+c, etc. */
                      yylval = (int) yytext[0];
                      return NUMBER;
                   }
\n                 { return EOL; }
[ \t]              { /* ignorar espacios y tabs */ }
.                  { yyerror("carácter desconocido"); }
%%
