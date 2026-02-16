/* Esto causará un conflicto SHIFT/REDUCE */
exp: factor
   | exp '|' factor  { $$ = $1 | $3; }    /* OR Binario */
   ;

term: NUMBER
    | '|' term       { $$ = abs($2); }    /* ABS Unario */
    ;
