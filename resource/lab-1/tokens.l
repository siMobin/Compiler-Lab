%{
int tokencount = 0;
%}

%%
[ ]+ {printf("White spaces ignored\n");}
\\\\.*.[\n]? {printf("%s is a comment\n",yytext);}
[a-zA-Z]+ {printf("%s is a token\n",yytext);tokencount++;}
[<>\-\+\?\*\/!\^,\(\);] {printf("%s is a token\n",yytext);tokencount++;}
[0-9] {}
[0-9]+ {printf("found a number");}
. {printf("Unexpected\n");}
%%

int main(){
	yylex();
	printf("Number of tokens is : %d\n",tokencount);
}
