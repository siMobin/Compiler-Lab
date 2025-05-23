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
int inc;
int var=0;
%}
%token NUMBER TOKEN PRINT FOR
%%
for_statement : for_cond statement ';' { printf("\n"); } 
	      ;
for_cond : FOR '(' condition_statement ')' { int count = 0;}
	 ;
condition_statement: TOKEN '=' expression ':' expression ':' expression {count_start=$3;count_end=$5; var=$1; inc = $7; }
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
		for(var=count_start;var<=count_end;var+=inc){
			printf("%d ",var);		
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

