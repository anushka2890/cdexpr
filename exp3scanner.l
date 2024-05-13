%{
#include <stdio.h>
%}

%%

[0-9]+          { printf("INTEGER: %s\n", yytext); }
[+-*/]          { printf("OPERATOR: %s\n", yytext); }
[ \t\n]         ; // Ignore whitespace and newline characters

.               { printf("ERROR: Unexpected character: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}


how to save:
flex scanner.l
gcc lex.yy.c -o lexer -lfl
./lexer
