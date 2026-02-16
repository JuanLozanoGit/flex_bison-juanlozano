/* fb1-5.y: calculadora simple */
%{
#include <stdio.h>
%}

%token NUMBER ADD SUB MUL DIV ABS EOL

%%
calclist: /* nada */
 | calclist exp EOL { printf("= %d\n", $2); }
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
 | ABS term { $$ = $2 >= 0? $2 : -$2; }
 ;
%%
main() { yyparse(); }
yyerror(char *s) { fprintf(stderr, "error: %s\n", s); }
