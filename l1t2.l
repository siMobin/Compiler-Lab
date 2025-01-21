%{
#include <stdio.h>
int variables = 0, variable_types = 0, operators = 0, digits = 0;
%}

%%

"int"|"float"|"double"|"char" { variable_types++; }
[a-zA-Z_][a-zA-Z0-9_]*       { variables++; }
[+\-*/=]                     { operators++; }
[0-9]                        { digits++; } // Count each digits

\\\\.*                       { /* Comments */ }
[ \t\n]                      { /* Ignore whitespace */ }
.                            { /* Ignore other characters */ }
%%

int main(){
// Input
    FILE *file;
    file = fopen("code.c", "r") ;
    if (!file) {
        printf("couldnot open file");
        exit (1);
    }
    else {
        yyin = file;
    }
    yylex();

// Output
    // printf("Enter your input:\n");
    printf("Counts:\n");
    printf("Variables: %d\n", variables);
    printf("Variable Types: %d\n", variable_types);
    printf("Operators: %d\n", operators);
    printf("Digits: %d\n", digits);
    return 0;
}

// Not Essential
int yywrap() {
    return 1;
}
