%{
	#include "simplY.tab.h"
%}

%option noyywrap

%%

"\n"		{ return EOLN; }
[a-z]+		{ yylval.stringval = yytext; return DECL; }
[0-9]+		{ yylval.intval = atoi(yytext); return INT; }

"+"			{ return PLUS; }
"-"			{ return MINUS; }
"*"			{ return MULT; }
"/"			{ return DIV; }
"PI"		{ return PI; }

"="			{ return EQUAL; }
"_print" 	{ return PRINT; }
"=="		{ return EQUAL_L;}
"&&"		{ return AND;}
"!="		{return NOT;}


%%
