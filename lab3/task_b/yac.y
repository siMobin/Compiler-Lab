%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
int yylex();
%}

/* Define a union to store double values */
%union {
    double dval;
}

/* Tell Yacc that NUMBER holds a double */
%token <dval> NUMBER
%type <dval> expressions

%left '+' '-'
%left '*' '/'

%%

statements: expressions { printf("= %lf\n", $1); }
    ;

expressions: expressions '+' expressions { $$ = $1 + $3; }
    | expressions '-' expressions { $$ = $1 - $3; }
    | expressions '*' expressions { $$ = $1 * $3; }
    | expressions '/' expressions { $$ = $1 / $3; }
    | '(' expressions ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

int main() {
    FILE *file;
    file = fopen("code.c", "r");
    if (!file) {
        printf("Could not open file\n");
        exit(1);
    }
    yyin = file;
    yyparse();
}
