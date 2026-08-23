# EJERCICIO 1

---

```
/*
* Handwritten version of scanner for calculator
*/
# include <stdio.h>
# include "fb1-5.tab.h"
FILE *yyin;
static int seeneof = 0;
int
yylex(void)
{
    if(!yyin) yyin = stdin;
    if(seeneof) return 0; /* saw EOF last time */
    while(1) {
        int c = getc(yyin);
        if(isdigit(c)) {
            int i = c - '0';
            while(isdigit(c = getc(yyin)))
                i = (10*i) + c-'0';
            yylval = i;
            if(c == EOF) seeneof = 1;
            else ungetc(c, yyin);
            return NUMBER;
        }
        switch(c) {
        case '+': return ADD; case '-': return SUB;
        case '*': return MUL; case '|': return ABS;
        case '(': return OP; case ')': return CP;
        case '\n': return EOL;
        case ' ': case '\t': break; /* ignore these */
        case EOF: return 0; /* standard end-of-file token */
        case '/': c = getc(yyin);
            if(c == '/') { /* it's a comment */
        while((c = getc(yyin)) != '\n')
            if(c == EOF) return 0; /* EOF in comment line */
        break;
            }
            if(c == EOF) seeneof = 1; /* it's division */
            else ungetc(c, yyin);
            return DIV;
        default: yyerror("Mystery character %c\n", c); break;
        }
    }
}
```

---

Will the calculator accept a line that contains only a comment? Why not? Would it be easier to fix this in the scanner or in the parser?

- ¿Acepta el calculador una línea que solo tenga un comentario?

    El programa al enontrar *//* sabe que es un comentario y lee los caracteres hasta *\n*.
    Al encontrarlo solo hace *break* y continúa en el bucle *while(1)*, mas no regresa el token *EOL*.
    Esto quiere decir que si la línea es un comentario, el escáner no genera token par esta, así que sigue leyendo como si nada.
    Entonces, sí acepta la línea, mas no la identifica, no hace nada con ella.


- ¿Se arregla más fácil en el escáner o el parser?

    Es más sencillo arregarlo en el escáner, pues será más fácil detectar el comentario, en lugar del *break*, se devolvería el EOL (*(return EOL)* en lugar de *break*)
