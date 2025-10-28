%option noyywrap

%{
#include<bits/stdc++.h>

#include"symbol_info.h"

#define YYSTYPE symbol_info*

#include "y.tab.h"

extern YYSTYPE yylval;

using namespace std;

void yyerror(char *);


string loglist;

extern int lines;

extern ofstream outlog;

%}

/* Regular Definitions */

delim	 [ \t\v\r]

/* write regular expressions for whitespace and newline */
ws		 {delim}+

newline  \n

letter_	 [A-Za-z_]
digit	 [0-9]

/* write regular expressions for id, float and integers */
id		 {letter_}({letter_}|{digit})*

integer  {digit}+

float    {digit}*\.{digit}+([eE][+-]?{digit}+)?|{digit}+[eE][+-]?{digit}+|{digit}+\.{digit}*([eE][+-]?{digit}+)?


%%

{ws}		{ /* ignore whitespace */ }
{newline}	{ 
                lines++; 
            }
if          { 
                loglist="Line no "+to_string(lines)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return IF; 
            }

else        { 
                loglist="Line no "+to_string(lines)+": Token <ELSE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ELSE; 
            }

for         { 
                loglist="Line no "+to_string(lines)+": Token <FOR> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return FOR; 
            }

while       { 
                loglist="Line no "+to_string(lines)+": Token <WHILE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return WHILE; 
            }

do          { 
                loglist="Line no "+to_string(lines)+": Token <DO> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return DO; 
            }

break       { 
                loglist="Line no "+to_string(lines)+": Token <BREAK> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return BREAK; 
            }

int         { 
                loglist="Line no "+to_string(lines)+": Token <INT> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return INT; 
            }

char        { 
                loglist="Line no "+to_string(lines)+": Token <CHAR> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return CHAR; 
            }

float       { 
                loglist="Line no "+to_string(lines)+": Token <FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return FLOAT; 
            }

double      { 
                loglist="Line no "+to_string(lines)+": Token <DOUBLE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return DOUBLE; 
            }

void        { 
                loglist="Line no "+to_string(lines)+": Token <VOID> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return VOID; 
            }

return      { 
                loglist="Line no "+to_string(lines)+": Token <RETURN> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return RETURN; 
            }

switch      { 
                loglist="Line no "+to_string(lines)+": Token <SWITCH> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return SWITCH; 
            }

case        { 
                loglist="Line no "+to_string(lines)+": Token <CASE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return CASE; 
            }

default     { 
                loglist="Line no "+to_string(lines)+": Token <DEFAULT> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return DEFAULT; 
            }

continue    { 
                loglist="Line no "+to_string(lines)+": Token <CONTINUE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return CONTINUE; 
            }

goto        { 
                loglist="Line no "+to_string(lines)+": Token <GOTO> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return GOTO; 
            }

printf      { 
                loglist="Line no "+to_string(lines)+": Token <PRINTF> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return PRINTF; 
            }

println     { 
                loglist="Line no "+to_string(lines)+": Token <PRINTLN> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return PRINTLN; 
            } 

{id}       {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ID;
            }

"+"|"-"	    {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ADDOP;
		    }

","        { 
                loglist="Line no "+to_string(lines)+": Token <COMMA> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;               
                return COMMA; }
