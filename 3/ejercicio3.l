%{
#include "ejercicio3.tab.h"
#include <stdlib.h>
%}

%%

"+"             { return ADD; }
"-"             { return SUB; }
"*"             { return MUL; }
"/"             { return DIV; }
"&"             { return AND; }
"|"             { return ABS; }

[0-9]+          {
                    yylval = atoi(yytext);
                    return NUMBER;
                }

\n              { return EOL; }

[ \t]           { }

.               {
                    printf("Mystery character %c\n", *yytext);
                }

%%
