%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int char_count = 0, word_count = 0, line_count = 0;
int whitespace_count = 0, tab_count = 0, special_char_count = 0;
int identifier_count = 0, keyword_count = 0, value_count = 0;

// List of C language keywords
char *keywords[] = {"int", "float", "char", "double", "return", "if", "else", "while", "for", "do", 
                    "switch", "case", "break", "continue", "struct", "union", "typedef", "void", 
                    "static", "extern", "const", "sizeof", "volatile", "enum", "register", "signed", 
                    "unsigned", "goto", "long", "short", "default", "auto"};

int keyword_count_size = sizeof(keywords) / sizeof(keywords[0]);

// Function to check if a word is a keyword
int is_keyword(char *word) {
    for (int i = 0; i < keyword_count_size; i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

%option noyywrap

%%


\n              { line_count++;  }


" "             {  whitespace_count++; }
"\t"            {  whitespace_count++; tab_count++; }


[0-9]+(\.[0-9]+)? { char_count += yyleng; value_count++; word_count++; printf("character:%s\n",yytext);}


[a-zA-Z_][a-zA-Z0-9_]* {
                      char_count += yyleng;
                      word_count++;
                      printf("Words: %s\n",yytext);
                      if (is_keyword(yytext)){ keyword_count++;                      printf("Keywords: %s\n",yytext);}
                      else {identifier_count++; printf("Identifiers: %s\n",yytext);}
                      
                  }


[{}()\[\],;:+\-*/=<>!&|%^~#] { char_count += yyleng; special_char_count++; }


.               { char_count++; }

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    printf("\nTotal Characters: %d\n", char_count);
    printf("Total Words: %d\n", word_count);
    printf("Total Lines: %d\n", line_count);
    printf("Whitespace Count: %d\n", whitespace_count);
    printf("Tab Space Count: %d\n", tab_count);
    printf("Special Character Count: %d\n", special_char_count);
    printf("Identifier Count: %d\n", identifier_count);
    printf("Keyword Count: %d\n", keyword_count);
    printf("Value Count: %d\n", value_count);

    return 0;
}