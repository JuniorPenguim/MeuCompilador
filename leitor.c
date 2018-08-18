%{
#define D	300
#define O	301
#define H	302
#define F	303
#define B	304
#define X	399
#define E 	400
#define S 	401

%}


CARACTERE         [A-Za-z]
DIGITO            [0-9]
OCTAL             0[0-7]*
HEXA              0x[0-9A-Fa-f]+
EXPO              ({INTEIRO}|{FLUTUANTE})"E"("+"|"-"){INTEIRO}
INTEIRO           {DIGITO}+
FLUTUANTE         {INTEIRO}"."{INTEIRO}
STRING            {CARACTERE}+({INTEIRO}|{CARACTERE})* 			  


%%





[1-9]{DIGITO}* 					{ return D; }
{OCTAL}							{ return O; }
{HEXA}           				{ return H; }
{FLUTUANTE}                 	{ return F; }
{EXPO}							{ return E; }
{STRING}						{ return S; }
[ \n\t]+						{ return B; }
.								{ return B; }
<<EOF>>							{ return X; }

%%

int main(int argc, char *argv[])
{
	FILE *f_in;
	int tipoToken;
	int totalDec = 0,
		totalOct = 0,
		totalHex = 0,
		totalFlt = 0,
		totalExp = 0,
		totalStr = 0;

	if(argc == 2)
	{
		if(f_in == fopen(argv[1], "r"))
		{
			yyin = f_in;
		}
		else
		{
			perror(argv[0]);
		}
	}
	else
	{
		yyin = stdin;
	}

	while((tipoToken = yylex()) != X)
	{
		switch (tipoToken)
		{
			case D:
				++totalDec;
				break;
			case O:
				++totalOct;
				break;
			case H:
				++totalHex;
				break;
			case F:
				++totalFlt;
				break;
			case E:
				++totalExp;
			case S:
				++totalStr;
		}
	}

	printf("Arquivo tem:\n");
	printf("\t %d valores decimais\n", totalDec);
	printf("\t %d valores octais\n", totalOct);
	printf("\t %d valores hexadecimais\n", totalHex);
	printf("\t %d valores flutuantes\n", totalFlt);
	printf("\t %d valores exponenciais\n", totalExp);
	printf("\t %d valores de strings\n", totalStr);
}
