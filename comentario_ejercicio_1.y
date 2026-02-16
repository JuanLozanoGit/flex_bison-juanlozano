/* Solución: Permitir EOL solitarios en la gramática */
calclist: /* nada */
 | calclist EOL { printf("> "); } /* Acepta línea vacía o solo comentario */
 | calclist exp EOL { printf("= %d\n> ", $2); }
 ;
