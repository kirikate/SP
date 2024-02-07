#include "stdio.h"
#include "morseTable.h"
#include "stdlib.h"
#include "parsers.h"
#include "translation.h"
#include "ctype.h"

int main(int argc, char* argv[]){
    for(int i = 0; i < argc; ++i){
        printf("arg number %i -- %s\n", i, argv[i]);
    }

    struct MorseCode* table =  getTable();

    int length;


    for(int i = 0; i < strlen(argv[1]); ++i){
        argv[1][i] = tolower(argv[1][i]);
    }
    char* res = toMorse(table, argv[1]);
    printf("res = %s\n", res);
    // char** res2 = parseToMorseLetters(&length, res);
    // for(int i = 0; i < length; ++i){
    //     printf("%s\n", res2[i]);
    // }
    char* res2 = fromMorse(table, res);
    printf("res = %s", res2);
    // for(int i = 0; i < length; ++i){
    //     free(res2[i]);
    // }
    free(res);
    free(res2);
    free(table);
}