%{
#include <stdio.h>
int regs[26];
int base;
%}

%union { int a; }
%token DIGIT LETTER

%%

list:
    |
    list stat '\n'
    |
    list error '\n' { yyerrok(); }

stat:
    expr { printf("%d\n", $1); }
    |
    LETTER '=' expr { regs[$1.a] = $3.a; }

expr:
    DIGIT { $$ = $1; }
    |
    LETTER { $$ = regs[$1.a]; }
    |
    expr '+' expr { $$ = $1 + $3; }
    |
    expr '-' expr { $$ = $1 - $3; }
    |
    expr '*' expr { $$ = $1 * $3; }
    |
    expr '/' expr { $$ = $1 / $3; }
    |
    expr '%' expr { $$ = $1 % $3; }

%%

int yyerror(char *s) {
    fprintf(stderr, "Parser error: %s\n", s);
    return 0;
}

int yylex();
