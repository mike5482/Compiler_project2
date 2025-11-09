/* CMSC 430 Compiler Theory and Design
   Project 2 Skeleton
   UMGC CITE
   Summer 2023 

   Project 2 Parser */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose


%token IDENTIFIER INT_LITERAL CHAR_LITERAL FLOAT_LITERAL HEX_LITERAL
%token ADDOP MULOP REMOP EXPOP NEGOP ANDOP OROP NOTOP RELOP ARROW
%token BEGIN_ CASE CHARACTER END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS RETURNS SWITCH WHEN
%token ELSE ELSEIF ENDFOLD ENDIF FOLD IF LEFT REAL RIGHT THEN

%%

function:
	function_header variable_list body ;

function_header:
    FUNCTION IDENTIFIER parameters RETURNS type ';'
  | FUNCTION IDENTIFIER RETURNS type ';'
  | FUNCTION error RETURNS type ';' ;


type:
	INTEGER |
	CHARACTER |
	REAL;

parameters:
    parameters ',' parameter
  | parameter
  | %empty ;

parameter:
    IDENTIFIER ':' type ;


variable_list:
    %empty
  | variable_list variable ;

variable:
	IDENTIFIER ':' type IS statement ';'
	| IDENTIFIER ':' LIST OF type IS list ';'
	| error ';' ;

list:
	'(' expressions ')'
	| IDENTIFIER;

expressions:
	expressions ',' expression|
	expression ;

body:
	BEGIN_ statement_ END ';' ;

statement_:
	statement ';' |
	error ';' ;

statement:
    expression
  | WHEN condition ',' expression ':' expression
  | WHEN error ';'
  | SWITCH expression IS cases OTHERS ARROW statement_ ENDSWITCH
  | IF condition THEN statement_ elsif_clauses ELSE statement_ ENDIF
  | FOLD direction operator expression IS list ARROW statement_ ENDFOLD
  | FOLD direction operator list ENDFOLD
    ;



elsif_clauses:
    elsif_clauses elsif_clause |
    %empty ;

elsif_clause:
    ELSEIF condition THEN statement_ ;

cases:
	cases case |
	%empty ;

case:
	CASE INT_LITERAL ARROW statement ';'
	| error ';' ;

condition:
	condition ANDOP relation |
	relation ;

relation:
	'(' condition ')' |
	expression RELOP expression |
	 expression ;

direction:
    LEFT
  | RIGHT
;

operator:
    ADDOP
  | MULOP
  | REMOP
  | EXPOP
  | NEGOP
;


expression:
    logical_or_expression ;

logical_or_expression:
    logical_or_expression OROP logical_and_expression
  | logical_and_expression ;

logical_and_expression:
    logical_and_expression ANDOP relational_expression
  | relational_expression ;

relational_expression:
    relational_expression RELOP additive_expression
  | additive_expression ;

additive_expression:
    additive_expression ADDOP multiplicative_expression
  | multiplicative_expression ;

multiplicative_expression:
    multiplicative_expression MULOP exponential_expression
  | multiplicative_expression REMOP exponential_expression
  | exponential_expression ;

exponential_expression:
    unary_expression EXPOP exponential_expression
  | unary_expression ;

unary_expression:
    NEGOP unary_expression
  | NOTOP unary_expression
  | primary ;

primary:
    '(' expression ')'
  | INT_LITERAL
  | FLOAT_LITERAL
  | HEX_LITERAL
  | CHAR_LITERAL
  | IDENTIFIER '(' expression ')'
  | IDENTIFIER ;
%%

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[]) {
	firstLine();
	yyparse();
	lastLine();
	return 0;
}
