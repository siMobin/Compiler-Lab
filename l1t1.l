%{
#include <stdio.h>
%}

%%
[0-9]*\.[0-9]+      { printf("Double/float numbers\n"); }
[0-9]+              {printf("Found Digits\n");}
^[AEIOUaeiou].*[AEIOUaeiou]$  { printf("Strings that start and end with a vowel\n"); }
^[A-Z][a-zA-Z0-9]*$ { printf("Strings start with capital letter\n"); }
.*[+\-*/=].*        { printf("Strings containing an operator somewhere\n"); }
.                   { printf("Unexpected character: %s\n", yytext); }
%%

int main() {
    printf("Enter input (Ctrl+D to stop on Linux/Mac or Ctrl+Z on Windows):\n");
    yylex();
    return 0;
}
