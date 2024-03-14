#include "stdio.h"
#include "morseTable.h"
#include "stdlib.h"
#include "parsers.h"
#include "translation.h"
#include "ctype.h"

int main(int argc, char* argv[]){
    if(argc == 1){
        printf("Enter the string in arg!!!\n");
        return 0;
    }
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
    // char* res2 = fromMorse(table, res);
    // printf("res = %s", res2);
    // for(int i = 0; i < length; ++i){
    //     free(res2[i]);
    // }

    // int wordCount = 0;
    // int* wordsLength = NULL;
    // printf("Enter parse to morse words\n");
    // char*** morseWords = parseToMorseWords(&wordCount, &wordsLength, res);
    // printf("Output this shit. Word number: %i\n", wordCount);
    // // output this shit
    // for(int i = 0; i < wordCount; ++i){
    //     printf("this word length: %i\n", wordsLength[i]);
    //     for(int j = 0; j < wordsLength[i]; ++j){
    //         printf("%s ", morseWords[i][j]);
    //     }
    //     printf("\n");
    // }

    char* res2 = fromMorse(table, res);
    printf("Result of detranslation: %s\n", res2);
    // clean up this abomination

    // free(wordsLength);
    // printf("After first free");
    // for(int i = 0; i < wordCount; ++i){
    //     for(int j = 0; j < wordsLength[i]; ++j){
    //         free(morseWords[i][j]);
    //     }
    // }

    free(res);
    free(res2);
    free(table);
}