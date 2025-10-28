%{

#include"symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);
void yyerror(char *);

extern FILE *yyin;


ofstream outlog;

int lines = 1;

%}

%token ID CONST_INT CONST_FLOAT
%token ADDOP MULOP INCOP DECOP ASSIGNOP RELOP LOGICOP NOT
%token LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA COLON SEMICOLON
%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE DEFAULT CONTINUE GOTO PRINTF PRINTLN

%nonassoc ELSE_LOWER
%nonassoc ELSE

%%

start : program
	{
		outlog<<"At line no: "<<lines<<" start : program "<<endl<<endl;
		outlog<<$1->getname()<<endl<<endl;
		$$ = new symbol_info($1->getname(),"start");
	}
	;

program : program unit
	{
		outlog<<"At line no: "<<lines<<" program : program unit "<<endl<<endl;
		outlog<<$1->getname()+"\n"+$2->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname()+"\n"+$2->getname(),"program");
	}
	| unit
	{

	}
	;

func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
		{	

		}
		| type_specifier ID LPAREN RPAREN compound_statement
		{
			
			outlog<<"At line no: "<<lines<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement "<<endl<<endl;
			outlog<<$1->getname()<<" "<<$2->getname()<<"()\n"<<$5->getname()<<endl<<endl;
			
			$$ = new symbol_info($1->getname()+" "+$2->getname()+"()\n"+$5->getname(),"func_def");	
		}
 		;

statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement
	  {
	    	outlog<<"At line no: "<<lines<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement "<<endl<<endl;
			outlog<<"for("<<$3->getname()<<$4->getname()<<$5->getname()<<")\n"<<$7->getname()<<endl<<endl;
			
			$$ = new symbol_info("for("+$3->getname()+$4->getname()+$5->getname()+")\n"+$7->getname(),"stmnt");
	  }

%%

int main(int argc, char *argv[])
{
	if(argc != 2) 
	{
        // check if filename given
	}
	yyin = fopen(argv[1], "r");
	outlog.open("my_log.txt", ios::trunc);
	
	if(yyin == NULL)
	{
		cout<<"Couldn't open file"<<endl;
		return 0;
	}
    
	yyparse();
	
	//print number of lines
	
	outlog.close();
	
	fclose(yyin);
	
	return 0;
}