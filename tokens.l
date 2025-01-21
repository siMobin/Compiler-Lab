%{
#include <stdio.h>
int tokencount = 0;
%}

%%
[ \t\n]+        {printf("White spaces ignored\n");}
\\\\.*          { printf("%s is a comment\n", yytext); }
[a-zA-Z]+       { printf("%s is a token\n", yytext); tokencount++; }
[=.\:<>\-\+\?\*\/!\^,\(\);] { printf("%s is a token\n", yytext); tokencount++; }
[0-9]*\.[0-9]+  { printf("%s is a float\n", yytext); tokencount++; }
[0-9]+          { printf("%s is an integer\n", yytext); tokencount++; }
.               { printf("Unexpected character: %s\n", yytext); }
%%

int main() {
    printf("Enter input (Ctrl+D to stop on Linux/Mac or Ctrl+Z on Windows):\n");
    yylex();
    printf("Number of tokens is: %d\n", tokencount);
    return 0;
}
