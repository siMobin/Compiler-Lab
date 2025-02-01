%{
// No Fuck'n variable required..!
%}

%%
CSE[ ]?0(61|6[2-9]|70)[0-9]{5}                                                         { printf("Valid student ID\n"); }
(23\.(34[3-9]|3[5-9][0-9]|[4-9][0-9][0-9])|2[4-9]\.[0-9]{3}|[3-9][0-9]\.[0-9]{3})      { printf("Double number in range 23.343 - 99.999\n"); }
[aeiouAEIOU]+[a-z]*[aeiouAEIOU]+|[aeiouAEIOU]+                                         { printf("String starting and ending with a vowel\n"); }
(12[8-9]|1[3-8][0-9]|19[0-1])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}       { printf("Class B IP address\n"); }
[0-9]+[a-zA-Z]+|[a-zA-Z]+[0-9]+                                                        { printf("Alphanumeric string with a digit at start or end\n"); }
[A-Z]+[a-z]*(\.?[ ]?[A-Z][a-z]*)*                                                      { printf("Valid name\n"); }

.                                      { printf("Unexpected character: %s\n", yytext); }
%%

int main() {
    printf("Enter input:\n");
    yylex();
    return 0;
}
