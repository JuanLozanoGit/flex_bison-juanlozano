#include <stdio.h>

int main() {
    int chars = 0, words = 0, lines = 0;
    int c, inword = 0;

    while((c = getchar()) != EOF) {
        chars++;
        if(c == '\n') lines++;
        if(c == ' ' || c == '\t' || c == '\n') {
            inword = 0;
        } else if(!inword) {
            inword = 1;
            words++;
        }
    }
    printf("%8d%8d%8d\n", lines, words, chars);
    return 0;
}
