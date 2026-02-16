/* fb1-2.l: Inglés -> Americano */
%%
"colour"  { printf("color"); }
"flavour" { printf("flavor"); }
"clever"  { printf("smart"); }
.         { printf("%s", yytext); }
%%
