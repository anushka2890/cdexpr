Write a program using FLEX.

%{
#include <stdio.h>
int linenum = 0;
%}

%%
"("   { printf("(\n"); }
")"   { printf(")\n"); }
"+"   { printf("+\n"); }
"-"   { printf("-\n"); }
"*"   { printf("*\n"); }
\n    { linenum++; }
[\t]+ { }
[0-9]+ { printf("%s\n", yytext); }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}

how to run:
flex lexer.l
gcc -o lexer lex.yy.c -lfl

./lexer
