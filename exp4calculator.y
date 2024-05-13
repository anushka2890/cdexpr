Write a program using BISON.

%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE
%left PLUS MINUS
%left TIMES DIVIDE

%%

calc: expr { printf("Result: %d\n", $1); }
    ;

expr: expr PLUS expr  { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr TIMES expr { $$ = $1 * $3; }
    | expr DIVIDE expr { 
        if ($3 != 0) {
            $$ = $1 / $3; 
        } else {
            fprintf(stderr, "Error: Division by zero\n");
            exit(EXIT_FAILURE);
        }
    }
    | NUMBER { $$ = $1; }
    | '(' expr ')' { $$ = $2; }
    ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    return 1;
}

int yylex() {
    int c = getchar();
    if (c == '+' || c == '-' || c == '*' || c == '/' || c == '(' || c == ')') {
        return c;
    } else if (c == '\n') {
        return 0;
    } else if (c >= '0' && c <= '9') {
        ungetc(c, stdin);
        int value;
        scanf("%d", &value);
        return NUMBER;
    } else if (c == EOF) {
        return 0;
    } else {
        return -1; // Error
    }
}

HOW TO RUN:
flex calculator.l
bison -dy calculator.y
gcc lex.yy.c y.tab.c -o calculator
./calculator