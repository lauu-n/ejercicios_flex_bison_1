#include <stdio.h>
#include <ctype.h>

int main(void) {
long lines = 0, words = 0, chars = 0;
int in_word = 0;
int c;

while ((c = getchar()) != EOF) {
chars++;
if (c == '\n') {
lines++;
}
if (isspace(c)) {
in_word = 0;
} else if (!in_word) {
in_word = 1;
words++;
}
}

printf("%8ld %8ld %8ld\n", lines, words, chars);
return 0;
}
