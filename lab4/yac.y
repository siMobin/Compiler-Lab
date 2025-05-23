%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

// Declare yyin to read from a file
extern FILE *yyin;

// Variable tables for 26 variables (a–z)
double vbltable[26];    // For floating-point variables
int vbltable2[26];      // For integer variables

// Error handler
void yyerror(const char *c){
    fprintf(stderr, "%s\n", c);
}

// Declare lexer function
int yylex();
%}

// that holds all possible data types that can be associated with tokens and non-terminal symbols in the grammar.
%union {
    double dval;  // for floating-point values
    int ival;     // for integer values
    int vblno;    // variable index (0 for 'a', 1 for 'b', ..., 25 for 'z')
}

// Token definitions
%token MINIMUM MAXIMUM SQRT EXPONENT
%token <vblno> NAME       // variable name: a-z
%token <dval> NUMBER      // floating-point numbers
%token <ival> INUMBER     // integer numbers

// Define types of nonterminals
%type <dval> expression term factor
%type <ival> expression2 term2 factor2

%%

// Entry point
inputs:
      statement_list     // for floating-point expressions
    | statement_list2    // for integer expressions
    ;

// ---------- FLOATING-POINT BLOCK ----------

statement_list:
      statement_list statement ';' '\n'
    | statement ';' '\n'
    ;

statement:
      NAME '=' expression {
          vbltable[$1] = $3;  // Assign value to variable
          printf("%c = %g\n", $1 + 'a', $3);
      }
    | expression {
          printf("= %g\n", $1); // Print evaluated result
      }
    ;

expression:
      expression '+' term { $$ = $1 + $3; }
    | expression '-' term { $$ = $1 - $3; }
    | term { $$ = $1; }
    ;

term:
      term '*' factor { $$ = $1 * $3; }
    | term '/' factor {
          if ($3 == 0.0) {
              yyerror("divide by zero");
          } else {
              $$ = $1 / $3;
          }
      }
    | factor { $$ = $1; }
    ;

factor:
      '-' factor { $$ = -$2; }
    | '(' expression ')' { $$ = $2; }
    | SQRT '(' expression ')' { $$ = sqrt($3); }
    | EXPONENT '(' expression ',' expression ')' { $$ = pow($3, $5); }
    | MINIMUM '(' expression ',' expression ')' { $$ = $3 < $5 ? $3 : $5; }
    | MAXIMUM '(' expression ',' expression ')' { $$ = $3 > $5 ? $3 : $5; }
    | NUMBER { $$ = $1; }
    | NAME { $$ = vbltable[$1]; }
    ;

// ---------- INTEGER BLOCK ----------

statement_list2:
      statement_list2 statement2 ';' '\n'
    | statement2 ';' '\n'
    ;

statement2:
      NAME '=' expression2 {
          vbltable2[$1] = $3;
          printf("%c = %d\n", $1 + 'a', $3);
      }
    | expression2 {
          printf("= %d\n", $1);
      }
    ;

expression2:
      expression2 '+' term2 { $$ = $1 + $3; }
    | expression2 '-' term2 { $$ = $1 - $3; }
    | term2 { $$ = $1; }
    ;

term2:
      term2 '*' factor2 { $$ = $1 * $3; }
    | term2 '/' factor2 {
          if ($3 == 0) {
              yyerror("divide by zero");
          } else {
              $$ = $1 / $3;
          }
      }
    | factor2 { $$ = $1; }
    ;

factor2:
      '-' factor2 { $$ = -$2; }
    | '(' expression2 ')' { $$ = $2; }
    | SQRT '(' expression2 ')' { $$ = sqrt($3); }
    | EXPONENT '(' expression2 ',' expression2 ')' { $$ = pow($3, $5); }
    | MINIMUM '(' expression2 ',' expression2 ')' { $$ = $3 < $5 ? $3 : $5; }
    | MAXIMUM '(' expression2 ',' expression2 ')' { $$ = $3 > $5 ? $3 : $5; }
    | INUMBER { $$ = $1; }
    | NAME { $$ = vbltable2[$1]; }
    ;

%%

int main() {
    FILE *file;
    file = fopen("code.c", "r");
    if (!file) {
        printf("could not open file\n");
        exit(1);
    } else {
        yyin = file;  // Set input for lexer
    }
    yyparse();        // Start parsing
    return 0;
}
