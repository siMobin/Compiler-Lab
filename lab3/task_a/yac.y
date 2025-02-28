%{
#include<stdio.h>
#include<stdlib.h>
extern FILE *yyin;
void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
int yylex();
%}

/* Operator Precedence and Associativity */
%left '+' '-'
%left '*' '/'

%token NUMBER
%%

statements: expressions { printf("= %d\n", $1); }
	;

expressions: expressions '+' expressions { $$ = $1 + $3; }
	| expressions '-' expressions { $$ = $1 - $3; }
	| expressions '*' expressions { $$ = $1 * $3; }
	| expressions '/' expressions { $$ = $1 / $3; }
	| '(' expressions ')' { $$ = $2; } /* Handling parentheses */
	| NUMBER { $$ = $1; }
	;

%%

int main(){
	FILE *file;
	file = fopen("code.c", "r");
	yyin = file;
	if (!file) {
		printf("could not open file\n");
		exit(1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}
