// CMSC 430 Compiler Theory and Design
//Michael Groves
// Project 1
// UMGC CITE
// 10/28/2025

// This file contains the function prototypes for the functions that produce
// the compilation listing

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

