%{
#include <iostream>
#include <string>
#include <sstream>

#define YYSTYPE atributos

using namespace std;

string declararVar()
{


}  

string gerarNome()
{
	static int numeroVariaveis = 0;
	numeroVariaveis++;
	ostringstream stringNumeroVariaveis;
	stringNumeroVariaveis << numeroVariaveis;
	return "TEMP" + stringNumeroVariaveis.str();
}  

 
  
struct atributos
{
	string label;
	string traducao;
	string tipo;
};

int yylex(void);
void yyerror(string);
%}

%token TK_NUM
%token TK_MAIN TK_ID TK_TIPO_INT
%token TK_FIM TK_ERROR


%start S

%left '+' '-'
%left '*' '/'

%%
  


S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << declararVar() << $5.traducao << "\treturn 0;\n}" << endl; 
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			|
			;

COMANDO 	: E ';'
			;

E 			: E '+' E
			{
        			string tempNome = gerarNome();
					$$.label = tempNome;
					$$.traducao = $1.traducao + $3.traducao + "\t" + tempNome + " = " + $1.label + " + " + $3.label + ";\n";
			}
      		| E '-' E
      		{
      				string tempNome = gerarNome();
					$$.label = tempNome;
					$$.traducao = $1.traducao + $3.traducao + "\t" + tempNome + " = " + $1.label + " - " + $3.label + ";\n";
      		}
      		| E '*' E
      		{
      	  			string tempNome = gerarNome();
					$$.label = tempNome;
					$$.traducao = $1.traducao + $3.traducao + "\t" + tempNome + " = " + $1.label + " * " + $3.label + ";\n";
	  		}
      		| E '/' E
      		{
      				string tempNome = gerarNome();
					$$.label = tempNome;
					$$.traducao = $1.traducao + $3.traducao + "\t" + tempNome + " = " + $1.label + " / " + $3.label + ";\n";
      		}
			| TK_NUM
			{
				string tempNome = gerarNome();
				$$.label = tempNome;
				$$.traducao = "\t"+ $1.tipo + " " + tempNome + " = " + $1.traducao + ";\n";
			}
			| TK_ID
			;

%%





#include "lex.yy.c"

int yyparse();

int main( int argc, char* argv[] )
{
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
