#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

enum yytokentype {
    NUMBER = 258,
    ADD = 259,
    SUB = 260,
    MUL = 261,
    DIV = 262,
    ABS = 263,
    EOL = 264
};

int yylval;

int yylex(void)
{
    int c;

    while ((c = getchar()) != EOF)
    {
        switch (c)
        {
            case '+':
                return ADD;

            case '-':
                return SUB;

            case '*':
                return MUL;

            case '/':
                return DIV;

            case '|':
                return ABS;

            case '\n':
                return EOL;

            case ' ':
            case '\t':
                continue;

            default:
                if (isdigit(c))
                {
                    int value = 0;

                    do
                    {
                        value = value * 10 + (c - '0');
                        c = getchar();
                    }
                    while (isdigit(c));

                    if (c != EOF)
                        ungetc(c, stdin);

                    yylval = value;
                    return NUMBER;
                }

                printf("Mystery character %c\n", c);
                break;
        }
    }

    return 0;
}

int main(void)
{
    int tok;

    while ((tok = yylex()) != 0)
    {
        printf("%d", tok);

        if (tok == NUMBER)
            printf(" = %d\n", yylval);
        else
            printf("\n");
    }

    return 0;
}
