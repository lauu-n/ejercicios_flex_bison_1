%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%token ADD SUB MUL DIV
%token AND
%token ABS
%token EOL

%left ABS
%left AND
%left ADD SUB
%left MUL DIV
%right UABS

%%

calclist:
      /* vacío */
    | calclist exp EOL
        {
            printf("= %d\n", $2);
        }
    ;

exp:
      NUMBER
        {
            $$ = $1;
        }
    | exp ADD exp
        {
            $$ = $1 + $3;
        }
    | exp SUB exp
        {
            $$ = $1 - $3;
        }
    | exp MUL exp
        {
            $$ = $1 * $3;
        }
    | exp DIV exp
        {
            $$ = $1 / $3;
        }
    | exp AND exp
        {
            $$ = $1 & $3;
        }
    | exp ABS exp
        {
            $$ = $1 | $3;
        }
    | ABS exp %prec UABS
        {
            $$ = ($2 >= 0) ? $2 : -$2;
        }
    ;

%%

int main(void)
{
    return yyparse();
}

void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
