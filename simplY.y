
%{
	#include <stdio.h>
	#include <stddef.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#define VARS_MAX 255

	void yyerror(char *s);

	/* test new variable system */

	struct var *ptr;

	struct var {
   int content;
   char type;
   char name[30];
};



	void assigned_int(char *s, int val);
	int get_value_int(char *s);
	void print_value(char *s);

%}

%union {int intval;
		char charval;
		char *stringval;}


%left PLUS MINUS
%left DIV MULT

%token <intval> INT PI
%token <charval> DECL_B EQUAL_L AND NOT EOLN PLUS MINUS DIV MULT EQUAL PRINT BOOL
%token <stringval> DECL

%type <intval> add_expr mul_expr primary
%type <charval> print line
%type <stringval> alloc

%%

line :
     | line EOLN
     | line add_expr EOLN { printf("%d\n", $2);}
     | line alloc EOLN
     | line print EOLN
     ;

print: alloc
     | PRINT alloc { print_value($2); }
     ;

alloc: DECL { $$ = $1; }
     /* integer var alloc */
     | alloc EQUAL add_expr { assigned_int( $1, $3 ); }

     ;

add_expr: mul_expr
        | add_expr PLUS mul_expr  { $$ = $1 + $3; }
        | add_expr MINUS mul_expr { $$ = $1 - $3; }
        | add_expr PLUS DECL	  { $$ = $1 + get_value_int($3); }
        | DECL PLUS add_expr      { $$ = get_value_int($1) + $3; }
        | add_expr MINUS DECL	  { $$ = $1 - get_value_int($3); }
        | DECL MINUS add_expr	  { $$ = get_value_int($1) - $3; }
        | DECL PLUS DECL 	  { $$ = get_value_int($1) + get_value_int($3); }
        | DECL MINUS DECL 	  { $$ = get_value_int($1) - get_value_int($3); }
        ;

mul_expr: primary
        | mul_expr MULT primary { $$ = $1 * $3; }
        | mul_expr DIV primary  { $$ = $1 / $3; }
        | mul_expr MULT DECL    { $$ = $1 * get_value_int($3); }
        | DECL MULT mul_expr	{ $$ = get_value_int($1) * $3; }
        | mul_expr DIV DECL 	{ $$ = $1 * get_value_int($3); }
        | DECL DIV mul_expr     { $$ = get_value_int($1) / $3; }
        | DECL MULT DECL 	{ $$ = get_value_int($1) * get_value_int($3); }
        | DECL DIV DECL 	{ $$ = get_value_int($1) / get_value_int($3); }
        ;


primary: INT { $$ = $1; }
       ;
%%


void assigned_int(char *line, int value)
{
	char var_name[255];
	strcpy(var_name,line);

	int i = 0;

	while (var_name[i] != ' ')
		i++;
	var_name[i] = '\0';

	i = 0;
	while (i < 10)
	{	
		printf("it's a test on line 107 : %s\n ", (ptr+i)->name);
		if ( strcmp((ptr+i)->name,"VOID") == 0)
		{
			strcpy((ptr+i)->name,var_name);
			(ptr+i)->content = value;
			return;

		}

		i++;
	}
		

		
}

void print_value(char *line){


	char var_name[255];
	strcpy(var_name,line);

	int i = 0;

	while (var_name[i] != '\n')
		i++;
	var_name[i] = '\0';

	i = 0;

	printf("it's a test on line 125 : %s\n ", var_name);

	
	while (i < 10)
	{
		printf("it's a test on line 137 : ptr name = %s; var_name = %s;\n", (ptr+i)->name, var_name);

		if (strcmp((ptr+i)->name, var_name) == 0)
		{
			printf("%d %wd %s\n", (ptr+i)->content, i, var_name);
			return;
		}
		
		//test
		
		i++;

	}

	if (i == 10)
	{
		printf("Error xd, you dump");
		return;
	}
	
}

int get_value_int(char *line){

	char var_name[255];
	strcpy(var_name,line);

	int i = 0;

	while (var_name[i] != ' ')
		i++;
	var_name[i] = '\0';

	i = 0;
	while (i < 30 && ( strcmp((ptr+i)->name,"VOID") == 0 || strcmp((ptr+i)->name,var_name) != 0 ))
		i++;
	return (ptr+i)->content;

}


void yyerror(char *s) { /* appelée par yyparse sur erreur de syntaxe */

	fprintf(stderr,"%s\n",s);
}

int main(void){

	int n = 10;


	ptr = (struct var*) malloc(n * sizeof(struct var));

	for (int i = 0; i < n; ++i)
	{
		strcpy((ptr+i)->name,"VOID");

	}
	int i = 0;


  yyparse();


}
