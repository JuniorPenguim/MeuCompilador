%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]
BOOL [true|false]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{NUM})\'
ID {LETRA}({LETRA}|{NUM})*


%%

"\n"		{}

{DELIM} 	{}

"(float)"|"(int)"   {yylval.label = yytext; return TK_CAST;}

"main"		{return TK_MAIN;}
"if"  		{return TK_IF;}
"else"		{return TK_ELSE;}

"int"		{yylval.label = yytext; return TK_TIPO;}
"float"     {yylval.label = yytext; return TK_TIPO;}
"bool"      {yylval.label = yytext; return TK_TIPO;}

"while"		{yylval.label = yytext; return TK_WHILE;}
"for"		{yylval.label = yytext; return TK_FOR;}
"do"		{yylval.label = yytext; return TK_DO;}

"true"      {yylval.label = "1"; yylval.tipo = "bool"; return TK_BOOL;}
"false"		{yylval.label = "0"; yylval.tipo = "bool"; return TK_BOOL;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }

[&|%]	{return *yytext; }

[<>!=]	{return *yytext; }

{NUM}		{ yylval.label = yytext; yylval.tipo = "int"; return TK_NUM; }
{ID}		{ yylval.nome_var = yytext; return TK_ID; }
{REAL}		{ yylval.label = yytext; yylval.tipo = "float"; return TK_NUM; }
{CHAR}      { yylval.label = yytext; yylval.tipo = "char"; return TK_NUM; }

.			{ *yytext; }

%%

int yywrap(void){
    return 1;
}