%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
int execute_stmt(int val, int dec); // prototype
extern FILE *yyin;

int var_value;
char *var_name;
%}



%union {
    int ival;
    char* sval;
}

%token <sval> ID
%token <ival> NUMBER
%token LOOP FROM PRINT
%token EQUALS LBRACE RBRACE SEMICOLON COLON MINUS

%type <ival> statement statements

%%

program:
    loop_statement
;

loop_statement:
    LOOP ID FROM NUMBER COLON NUMBER LBRACE statements RBRACE {
        var_name = $2;
        var_value = $4;
        int limit = $6;
        while (var_value > limit) {
            printf("%d ", var_value);
            var_value = execute_stmt(var_value, $8);  // $8 = decrement
        }
        printf("\n");
    }
;

statements:
    statement {
        $$ = $1;
    }
;

statement:
    PRINT ID SEMICOLON ID EQUALS ID MINUS NUMBER SEMICOLON {
        $$ = $8; // return decrement value
    }
;

%%

int execute_stmt(int val, int dec) {
    return val - dec;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyin = fopen("code.c", "r");  // ✅ read from file
    if (!yyin) {
        perror("Cannot open file code.c");
        return 1;
    }
    yyparse();
    fclose(yyin);
    return 0;
}

