%{
	#include "simplY.tab.h"
%}

%option noyywrap

%%

"\n"		{ return EOLN; }
[a-z]		{ yylval = yytext[0]; return DECL; }
[0-9]+		{ yylval = atoi(yytext); return INT; }
"b"[a-z]	{ yylval = yytext[0]; return DECL_B; }
"b"[0-1]	{ yylval = yytext[1]; return BOOL;}
"+"			{ return PLUS; }
"-"			{ return MINUS; }
"*"			{ return MULT; }
"/"			{ return DIV; }
"PI"		{ return PI; }

"="			{ return EQUAL; }
"print" 	{ return PRINT; }
"=="		{ return EQUAL_L;}
"&&"		{ return AND;}
"!="		{return NOT;}


%%