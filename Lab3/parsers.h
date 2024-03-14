#ifndef PARSERS
#define PARSERS

#include <string.h>
#include "stdlib.h"
#include "stdio.h"

char** parseToWords(int* length_out, const char* text);

char*** parseToMorseWords(int* length_out, int** lengthOfWords_out, const char* text);

char** parseToMorseLetters(int* length_out, const char* text);

void substr(const char* src, char* dst, int beg, int end);

void addStr(char* dst, const char* newstr, int* cursor);
#endif