#ifndef TRANSLATION
#define TRANSLATION
#include "morseTable.h"
#include "parsers.h"
#include "stdio.h"

char* toMorse(struct MorseCode* table, char* text);

char* fromMorse(struct MorseCode* table, char* text);
#endif