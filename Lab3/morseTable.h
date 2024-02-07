#ifndef MORSE_TABLE
#define MORSE_TABLE

#include "string.h"
#include "stdlib.h"

struct MorseCode{
    char letter;
    char code[7];
};

struct MorseCode* getTable();
#endif