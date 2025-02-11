%{
#include <stdio.h>
%}

%%

[0-9]+      { printf("%s\n", yytext); }  // Print each number on a new line
.        {  }
\n          {return 0;}

%%

int main() {
    yylex();  
    return 0;
}

int yywrap() {
    return 1;  // Indicates the end of input
}