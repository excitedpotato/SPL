
%{	
	#include <stdio.h>
	#include <stddef.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#define VARS_MAX 255
	/* var function to int object */

	void yyerror(char *s);	
	void assi_int(char  name, int val);	
	void var_print_int(char name);
	unsigned var_get_index_int(char name);
	int var_get_value_int(char name);

	/* var function to bool object */

	int math_var[26];

%}

%left PLUS MINUS
%left DIV MULT

%token EOLN PLUS MINUS DIV MULT INT DECL EQUAL PRINT BOOL PI
%token DECL_B EQUAL_L AND NOT
%%

line : 
     | line EOLN
     | line add_expr EOLN { printf("%d\n", $2);}	
     | line alloc EOLN 
     | line print EOLN
     ;

print: alloc
     | PRINT alloc { var_print_int($2); }
     ;

alloc: DECL { $$ = $1; }
     /* integer var alloc */ 
     | alloc EQUAL add_expr { assi_int( $1, $3 ); }

     ; 

add_expr: mul_expr
        | add_expr PLUS mul_expr  { $$ = $1 + $3; }
        | add_expr MINUS mul_expr { $$ = $1 - $3; }
        | add_expr PLUS DECL	  { $$ = $1 + var_get_value_int($3); }
        | DECL PLUS add_expr      { $$ = var_get_value_int($1) + $3; }
        | add_expr MINUS DECL	  { $$ = $1 - var_get_value_int($3); }  
        | DECL MINUS add_expr	  { $$ = var_get_value_int($1) - $3; }  	
        | DECL PLUS DECL 	  { $$ = var_get_value_int($1) + var_get_value_int($3); }
        | DECL MINUS DECL 	  { $$ = var_get_value_int($1) - var_get_value_int($3); } 
        ;

mul_expr: primary
        | mul_expr MULT primary { $$ = $1 * $3; }
        | mul_expr DIV primary  { $$ = $1 / $3; }
        | mul_expr MULT DECL    { $$ = $1 * var_get_value_int($3); }	
        | DECL MULT mul_expr	{ $$ = var_get_value_int($1) * $3; } 
        | mul_expr DIV DECL 	{ $$ = $1 * var_get_value_int($3); }
        | DECL DIV mul_expr     { $$ = var_get_value_int($1) / $3; }
        | DECL MULT DECL 	{ $$ = var_get_value_int($1) * var_get_value_int($3); }
        | DECL DIV DECL 	{ $$ = var_get_value_int($1) / var_get_value_int($3); } 
        ;


primary: INT { $$ = $1; }       
       ;
%%

unsigned var_get_index_int(char name)
{
	char alphabet[26];
	char base = 'a';
	int it = 0; 
	while (base < 'z')
	{
		alphabet[it] = base;
		base++;
		it++;
	}	

	int i = 0;

	while (alphabet[i] < name)
		i++;
	return i;
}


void assi_int(char name, int val)

{	
	unsigned i = var_get_index_int(name);
	math_var[i] = val; 

	
}

void var_print_int(char name)
{
	unsigned i = var_get_index_int(name);
	printf("%d\n", math_var[i]);
}

int var_get_value_int(char name)
{
	unsigned i = var_get_index_int(name);
	return math_var[i];
}



void yyerror(char *s) { /* appelée par yyparse sur erreur de syntaxe */
	
	fprintf(stderr,"%s\n",s);
}

int main(void){ 
  yyparse();
	
}