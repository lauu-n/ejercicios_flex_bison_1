%{
#include <stdio.h>
int lines = 0, words = 0, chars = 0;
%}

%%
\n          { lines++; chars++; }
[^\t\n ]+   { words++; chars += yyleng; }
.           { chars++; }
%%

int main(void) {
    yylex();
    printf("%8d %8d %8d\n", lines, words, chars);
    return 0;
}

int yywrap(void) {
    return 1;
}
