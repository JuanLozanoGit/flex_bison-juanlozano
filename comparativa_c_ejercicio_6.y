#include <stdio.h>
#include <ctype.h>

int main() {
    int c, nl = 0, nw = 0, nc = 0, state = 0;
    while ((c = getchar()) != EOF) {
        nc++;
        if (c == '\n') nl++;
        if (isspace(c)) state = 0;
        else if (state == 0) {
            state = 1;
            nw++;
        }
    }
    printf("Lineas: %d, Palabras: %d, Caracteres: %d\n", nl, nw, nc);
    return 0;
}
