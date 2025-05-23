%{
#include "y.tab.h"
#include <math.h>
extern double vbltable[26]; // External variable: table for storing values of double variables 'a' to 'z'
extern int vbltable2[26]; // External variable: table for storing integer values 'a' to 'z'
%}
%%
[0-9]+ {
	yylval.ival = atoi(yytext); return INUMBER;
}
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
	yylval.dval = atof(yytext); return NUMBER;
}
"sqrt" {return SQRT;}
"minimum" {return MINIMUM;}
"maximum" {return MAXIMUM;}
"exponent" {return EXPONENT;}
[ \t] ; /* ignore whitespace */
[a-z] { yylval.vblno = yytext[0] - 'a'; return NAME; }
\n|. return yytext[0];
%%
