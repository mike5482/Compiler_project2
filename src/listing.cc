// CMSC 430 Compiler Theory and Design
//Michael Groves
// Project 1
// UMGC CITE
// 10/28/2025

// This file contains the bodies of the functions that produces the 
// compilation listing

#include <cstdio>
#include <string>
#include <vector>

using namespace std;

#include "../include/listing.h"
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;
static int totalErrors = 0;
static int lineNumber;


static vector<string> errorQueue;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");

	if (totalErrors > 0)
	{
		printf("Lexical Errors: %d\n", lexicalErrors);
		printf("Syntactic Errors: %d\n", syntaxErrors);
		printf("Semantic Errors: %d\n", semanticErrors);
	}
	else
	{
		printf("Compiled Successfully\n");
	}

	return totalErrors;
}

    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = {
		"Lexical Error, Invalid Character ",
		"Syntactic Error, ",
		"Semantic Error, ",
		"Semantic Error, Duplicate ",
		"Semantic Error, Undeclared "
	};

	errorQueue.push_back(messages[errorCategory] + message);
	totalErrors++;

	switch (errorCategory)
	{
	case LEXICAL:
		lexicalErrors++;
		break;
	case SYNTAX:
		syntaxErrors++;
		break;
	case GENERAL_SEMANTIC:
	case DUPLICATE_IDENTIFIER:
	case UNDECLARED:
		semanticErrors++;
		break;
	}
}

void displayErrors()
{
	for (const string& msg : errorQueue)
	{
		printf("%s\n", msg.c_str());
	}
	errorQueue.clear();
}

