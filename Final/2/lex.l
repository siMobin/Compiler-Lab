%{
#include "y.tab.h"
%}

%%

"loop"              { return LOOP; }
"from"              { return FROM; }
"print"             { return PRINT; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return ID; }
[0-9]+              { yylval.ival = atoi(yytext); return NUMBER; }

"="                 { return EQUALS; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
";"                 { return SEMICOLON; }
":"                 { return COLON; }
"-"                 { return MINUS; }

[ \t\r\n]+          { /* ignore whitespace */ }
.                   { return yytext[0]; }

%%

