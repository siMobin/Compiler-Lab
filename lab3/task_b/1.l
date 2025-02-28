%{
#include <stdlib.h>
#include "y.tab.h"
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.dval = atof(yytext); return NUMBER; }
[ \t]+              { /* Ignore whitespace */ }
\n                  { return 0; } /* Logical EOF */
.                   { return yytext[0]; }

%%
