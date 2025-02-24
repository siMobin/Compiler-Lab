%{
#include<stdio.h>
#include<stdlib.h>
extern FILE *yyin;
void yyerror(char *s){
	fprintf(stderr, "%s",s);
}
int yylex();
%}

%token NUMBER
%%
statements: expressions { printf("= %d\n",$1); }
	;
expressions: expressions '+' NUMBER { $$ = $1 + $3; }
	| expressions '-' NUMBER { $$ = $1 - $3; }
	| expressions '*' NUMBER { $$ = $1 * $3; }
	| expressions '/' NUMBER { $$ = $1 / $3; }
	| NUMBER { $$ = $1; }
	;
%%
int main(){
	FILE *file;
	file = fopen("code.c", "r") ;
	yyin = file;
	if (!file) {
		printf("couldnot open file");
		exit(1);	
	}
	else{
		yyin = file;
	}
	yyparse();
}