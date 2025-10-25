// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the enumerated type definition for tokens

enum Tokens {ADDOP=256, MULOP=257, ANDOP=258, RELOP=259, ARROW=260, BEGIN_=261, CASE=262, CHARACTER=263, END=264,
     ENDSWITCH=265, FUNCTION=266, INTEGER=267, IS=268, LIST=269, OF=270, OTHERS=271, RETURNS=272, SWITCH=273, WHEN=274,
     IDENTIFIER=275, INT_LITERAL=276, CHAR_LITERAL=277, ELSE=278, ELSEIF=279, ENDFOLD=280, ENDIF=281, FOLD=282, IF=283,
    LEFT=284, REAL=285, RIGHT=286, THEN=287, FLOAT_LITERAL=288, OROP=289, NOTOP=290, REMOP = 291, EXPOP = 292,
    NEGOP = 293, HEX_LITERAL=294};

enum RelationalOperator {
    EQ,     // =
    NEQ,    // <>
    GT,     // >
    GE,     // >=
    LE      // <=
};

enum AddOperator {
    ADD, // +
    SUB  // -
};