%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char base11[100];
int i_index = 0;
int count_gt6 = 0;
int parsing = 0;  // flag to know when inside ( )

int value_of(char ch) {
    if (isdigit(ch)) return ch - '0';
    if (ch == 'A' || ch == 'a') return 10;
    return -1;
}
%}

%%

"("            { parsing = 1; }
")"            { parsing = 0; }

[0-9Aa]        {
    if (parsing) {
        base11[i_index++] = yytext[0];
        int val = value_of(yytext[0]);
        if (val > 6) count_gt6++;
    }
}

.|\n           ; // Ignore everything else

%%

int main() {
    char input[200];
    printf("Enter a base-11 number (e.g., (201A22)11): ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0;

    i_index = 0;
    count_gt6 = 0;
    parsing = 0;

    YY_BUFFER_STATE buffer = yy_scan_string(input);
    yylex();
    yy_delete_buffer(buffer);

    base11[i_index] = '\0';

    int decimal = 0;
    for (int i = 0; i < i_index; i++) {
        int digit = value_of(base11[i]);
        decimal = decimal * 11 + digit;
    }

    printf("(%d)10\n", decimal);
    printf("The number of digits >6 is %d\n", count_gt6);

    return 0;
}

