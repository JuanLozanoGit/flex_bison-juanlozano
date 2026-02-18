%{
#include <stdio.h>
void yyerror(char *s);
int yylex();
%}

%token NUMBER ADD SUB MUL DIV ABS EOL

%%
calclist: /* nada */
 | calclist exp EOL { printf("= %d (hex: 0x%X)\n> ", $2, $2); }
 | calclist EOL     { printf("> "); }
 ;

exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER
 | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
 ;
%%

void yyerror(char *s) { fprintf(stderr, "error: %s\n", s); }
int main() { printf("> "); yyparse(); return 0; }
