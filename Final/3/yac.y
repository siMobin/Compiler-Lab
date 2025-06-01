%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yyparse(void);
void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;

double nCr(int n, int r) {
    if (r > n || r < 0 || n < 0) return 0;
    double res = 1;
    for (int i = 1; i <= r; ++i) {
        res *= (n - i + 1);
        res /= i;
    }
    return res;
}

int main() {
    FILE *file = fopen("code.c", "r");
    if (!file) {
        fprintf(stderr, "Could not open file: code.c\n");
        exit(1);
    }
    yyin = file;   // Set lexer input
    yyparse();     // Parse all expressions
    fclose(file);
    return 0;
}
%}

%union {
    double fval;
}

%token <fval> NUMBER
%token ROOT EXP SEC NCR
%token LPAREN RPAREN COMMA EOL

%type <fval> expr

%%

input:
    /* empty */
    | input expr EOL { printf("%lf\n", $2); }
    ;

expr:
      NUMBER                         { $$ = $1; }
    | ROOT LPAREN expr COMMA expr RPAREN { $$ = pow($3, 1.0 / $5); }
    | EXP LPAREN expr COMMA expr RPAREN  { $$ = pow($3, $5); }
    | SEC LPAREN expr RPAREN            { $$ = 1.0 / cos($3 * M_PI / 180.0); }
    | NCR LPAREN expr COMMA expr RPAREN { $$ = nCr((int)$3, (int)$5); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

