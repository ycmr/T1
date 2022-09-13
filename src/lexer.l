%option noyywrap yylineno nodefault
%{

#include <stdio.h>

typedef enum {
    ERROR = 258,
    ID,
    KEY,
    NUM,
    SYM
} token_t;

%}

%%





%%

int main(int argc, char **argv) {
    token_t token;

    extern FILE *yyin; 
    FILE *fout; 

    if (argc > 2) {
        if(!(yyin = fopen(argv[1], "r"))) {
            printf("erro na abertura do arquivo de entrada %s\n",argv[1]);
            return (1); 
        }
    	if(!(fout = fopen(argv[2], "w"))) {
            printf("erro na criacao do arquivo de saida %s\n",argv[2]);
            return (1);
        }
    } 
    else {
	printf("erro no número de argumentos passados para lexer\n");
        return (1);
    }

    while ((token = yylex())) {
        switch (token) {
            case ERROR:
               fprintf(fout, "(%d,ERROR,\"%s\")\n", yylineno, yytext);
               break;
            case NUM: 
               fprintf(fout, "(%d,NUM,\"%s\")\n", yylineno, yytext);
               break; 
            case ID: 
               fprintf(fout, "(%d,ID,\"%s\")\n", yylineno, yytext);
               break;
            case KEY:
               fprintf(fout, "(%d,KEY,\"%s\")\n", yylineno, yytext);
               break;
            case SYM: 
               fprintf(fout, "(%d,SYM,\"%s\")\n", yylineno, yytext);
               break;
        }
    }
    fclose(fout);
}

