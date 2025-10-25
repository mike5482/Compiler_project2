/* CMSC 430 Compiler Theory and Design
   Project 1 Skeleton
   UMGC CITE
   Summer 2023 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		"//".*\n
line		[\n]
id     [A-Za-z]([A-Za-z0-9]*(_{1,2}[A-Za-z0-9]+)*)?
digit		[0-9]
float    ({digit}+\.[0-9]*|\.[0-9]+)([eE][+-]?{digit}+)?
dec		{digit}+
hex     "#"([0-9A-Fa-f]+)
char    '.'
charn   '\\n'
charb   '\\b'
chart   '\\t'
charr   '\\r'
charf   '\\f'
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"--".*        { /* Ignore single-line comment */ }
"+"     { ECHO; /*yylval.op = ADD;*/ return(ADDOP); }
"-"     { ECHO; /*yylval.op = SUB;*/ return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"/"     { ECHO; return(MULOP); }     // Division operator
"%"     { ECHO; return(REMOP); }     // Remainder operator
"^"     { ECHO; return(EXPOP); }     // Exponentiation operator
"~"     { ECHO; return(NEGOP); }     // Unary minus operator
"&"		{ ECHO; return(ANDOP); }
"<"		{ ECHO; return(RELOP); }
"="     { ECHO; /*yylval.op = EQ;  */ return(RELOP); }
"<>"    { ECHO; /*yylval.op = NEQ; */ return(RELOP); }
">"     { ECHO; /*yylval.op = GT;  */ return(RELOP); }
">="    { ECHO; /*yylval.op = GE;  */ return(RELOP); }
"<="    { ECHO; /*yylval.op = LE;  */ return(RELOP); }
"|"     { ECHO; return(OROP); }
"!"     { ECHO; return(NOTOP); }
"=>"		{ ECHO; return(ARROW); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else        { ECHO; return(ELSE); }
elsif       { ECHO; return(ELSEIF); }
endfold     { ECHO; return(ENDFOLD); }
endif       { ECHO; return(ENDIF); }
fold        { ECHO; return(FOLD); }
if          { ECHO; return(IF); }
left        { ECHO; return(LEFT); }
real        { ECHO; return(REAL); }
right       { ECHO; return(RIGHT); }
then        { ECHO; return(THEN); }
{id}		{ ECHO; return(IDENTIFIER);}
{hex}      { ECHO; return(HEX_LITERAL); }
{float}    { ECHO; return(FLOAT_LITERAL); }
{dec}		{ ECHO; return(INT_LITERAL); }
{charb}     { ECHO; return(CHAR_LITERAL); }
{chart}     { ECHO; return(CHAR_LITERAL); }
{charn}     { ECHO; return(CHAR_LITERAL); }
{charr}     { ECHO; return(CHAR_LITERAL); }
{charf}     { ECHO; return(CHAR_LITERAL); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%

int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}