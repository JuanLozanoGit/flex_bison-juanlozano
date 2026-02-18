%{
#include <stdio.h>
void yyerror(char *s);
int yylex();
%}

%token NUMBER ADD SUB MUL DIV ABS EOL

/* Precedencia para resolver ambigüedad */
%left ADD SUB
%left MUL DIV
%nonassoc ABS

%%
calclist: /* nada */
 | calclist exp EOL { printf("= %d\n> ", $2); }
 | calclist EOL     { printf("> "); }
 ;

exp: NUMBER
 | exp ADD exp { $$ = $1 + $3; }
 | exp SUB exp { $$ = $1 - $3; }
 | exp MUL exp { $$ = $1 * $3; }
 | exp DIV exp { $$ = $1 / $3; }
 | ABS exp ABS { $$ = $2 >= 0 ? $2 : -$2; } /* Uso de | como delimitador */
 ;

%%
void yyerror(char *s) { fprintf(stderr, "error: %s\n", s); }
int main() { printf("> "); yyparse(); return 0; }
