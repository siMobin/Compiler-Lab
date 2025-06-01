%{
#include "y.tab.h"
#include <stdlib.h>
#include <math.h>
%}

%%
[0-9]+(\.[0-9]+)?    { yylval.fval = atof(yytext); return NUMBER; }
"root"               { return ROOT; }
"exp"                { return EXP; }
"sec"                { return SEC; }
"nCr"                { return NCR; }
"("                  { return LPAREN; }
")"                  { return RPAREN; }
","                  { return COMMA; }
[\n]                 { return EOL; }
[ \t]+               { /* skip whitespace */ }
.                    { return yytext[0]; }
%%

