%{
#include "y.tab.h"
#include <stdio.h>

char addtotable(char, char, char);
int index1 = 0;
char temp = 'A' - 1;

struct expr {
    char operand1;
    char operand2;
    char operator;
    char result;
};

// Declare yyerror before using it
void yyerror(const char *s);
%}

%union {
    char symbol;
}

%left '+' '-'
%left '/' '*'
%token <symbol> LETTER NUMBER
%type <symbol> exp

%%

statement: LETTER '=' exp ';' {
                addtotable((char)$1, (char)$3, '=');
            };

exp: exp '+' exp {
                $$ = addtotable((char)$1, (char)$3, '+');
            }
    | exp '-' exp {
                $$ = addtotable((char)$1, (char)$3, '-');
            }
    | exp '/' exp {
                $$ = addtotable((char)$1, (char)$3, '/');
            }
    | exp '*' exp {
                $$ = addtotable((char)$1, (char)$3, '*');
            }
    | '(' exp ')' {
                $$ = (char)$2;
            }
    | NUMBER {
                $$ = (char)$1;
            }
    | LETTER {
                $$ = (char)$1;
            };

%%

struct expr arr[20];

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

char addtotable(char a, char b, char o) {
    temp++;
    arr[index1].operand1 = a;
    arr[index1].operand2 = b;
    arr[index1].operator = o;
    arr[index1].result = temp;
    index1++;
    return temp;
}

void threeAdd() {
    int i = 0;
    while (i < index1) {
        printf("%c = %c %c %c\n", arr[i].result, arr[i].operand1, arr[i].operator, arr[i].operand2);
        i++;
    }
}

int find(char t) {
    int i;
    for (i = 0; i < index1; i++) {
        if (arr[i].result == t)
            break;
    }
    return i;
}

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the expression:\n");
    yyparse();
    threeAdd();
    return 0;
}
