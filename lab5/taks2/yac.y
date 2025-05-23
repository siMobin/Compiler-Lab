%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *s){
	fprintf(stderr,"%s\n",s);
}
extern FILE *yyin;
int yylex();
int count_start;
int count_end;
int var=0;
%}
%token NUMBER TOKEN PRINT WHILE
%%
while_statement : while_cond statement ';' { printf("\n"); } 
	      ;
while_cond : WHILE '(' condition_statement ')' { int count = 0;}
	 ;
condition_statement: expression '<' '=' TOKEN '<' '=' expression {count_start=$1;count_end=$7; var=$4;}
	;

expression: expression '+' term { $$ = $1 + $3; }
	  | expression '-' term { $$ = $1 - $3; }
	  | term { $$=$1;}
	  ;
term: term '*' factor { $$ = $1 * $3; }
    | term '/' factor 
      { 
	  if($3==0.0){
		  yyerror ("divide by zero");  
	  }	
	  else{
 		  $$ = $1 / $3;
	  }
      }
    | factor { $$=$1;}
    ;
factor: '-' factor { $$ = -$2; }
      | '(' expression ')' { $$ = $2; }
      | NUMBER {$$ = $1;}
	  ;

statement: PRINT TOKEN { if(var==$2){
		var = count_start;
		while(var<=count_end){
			printf("%d ", var);
			var++;
		}
	} }
	 ;



%%
int main(){
	FILE *file;
	file = fopen("code.c", "r") ;
	if (!file) {
		printf("could not open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

