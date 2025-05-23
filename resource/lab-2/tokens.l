%{
//For today we do not need any variables
%}
%%

123[0-5]|12[0-2][0-9]|1[0-1][0-9][0-9]|[1-9][0-9][0-9]|[8-9][0-9]|7[2-9] {printf("%s - Found a decimal number within 72 - 1235.\n",yytext);}
12\.(0[2-9]|[1-9][0-9])|1[3-9]\.[0-9][0-9]|[2-8][0-9]\.[0-9][0-9]|9[0-8]\.[0-9][0-9]|99\.([0-8][0-9]|9[0-3]) {printf("%s - Found a double number within 12.02 - 99.93.\n",yytext);}
[0-9]+\.[0-9]+ {printf("%s - Found a double number.\n",yytext);}
[0-9]+ {printf("%s - Found a decimal number.\n",yytext);}
([0-9]|[0-9][0-9]|1[0-1][0-9]|12[0-7])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9][0-9]|[0-9])){3} {printf("%s - Found a class A IP address.\n",yytext);}
^[AEIOU][a-zA-Z]* {printf("%s - Found an alphabet string that starts with a capital letter vowel.\n",yytext);}
[a-zA-Z]*[aeiou] {printf("%s - Found an alphabet string that ends with a small letter vowel.\n",yytext);}
[a-zA-Z0-9]*[0-9]+[a-zA-Z0-9]* {printf("%s - Found a string that has a number in it.\n",yytext);}
%%
int main(){
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
}