#include "translation.h"

char* toMorse(struct MorseCode* table, char* text){
    int length;

    char** words = parseToWords(&length, text);
    int symbols = 0;
    for(int i = 0; i < length; ++i){
        symbols += strlen(words[i]);
    }

    int lengthOfArray = symbols * 8 + (length - 1) * 7 + 1;
    // printf("%i\n", lengthOfArray);
    char* res = (char*) malloc(sizeof(char) * lengthOfArray);
    //char* res = new char[lengthOfArray];


    int cursor = 0;

    for(int i = 0; i < length; ++i){
        for(int j = 0; j < strlen(words[i]); ++j){

            int s = 0;

            while (table[s].letter != words[i][j]) ++s;

            addStr(res, table[s].code, &cursor);

            // printf("added letter %c\n", words[i][j]);

            if(j == strlen(words[i]) - 1) continue;

            const char* gap = "   ";
            addStr(res, gap, &cursor);

        }
        
        if(i == length - 1) continue;

        const char* word_gap = "       ";
        addStr(res, word_gap, &cursor);
    }
    for(int i = 0; i < length; ++i){
        free(words[i]);
    }

    free(words);
    res[cursor] = '\0';
    // printf("real length %i, cursor = %i, arraylength = %i", (int)strlen(res), cursor, lengthOfArray);
    return res;
}

char* fromMorse(struct MorseCode* table, char* text){
    int length;

    char** words = parseToMorseLetters(&length, text);
    int symbols = 0;
    for(int i = 0; i < length; ++i){
        symbols += strlen(words[i]);
    }

    int lengthOfArray = symbols + (length - 1) * 7 + 1;
    // printf("%i\n", lengthOfArray);
    char* res = (char*) malloc(sizeof(char) * lengthOfArray);
    //char* res = new char[lengthOfArray];


    int cursor = 0;

    for(int i = 0; i < length; ++i){
        int s = 0;

        while (strcmp(table[s].code, words[i])) ++s;

        // addStr(res, table[s].letter, &cursor);
        res[cursor] = table[s].letter;
        ++cursor;

            // printf("added letter %c\n", words[i][j]);

            // if(j == strlen(words[i]) - 1) continue;

            // const char* gap = "   ";
            // addStr(res, gap, &cursor);

        //}
        
        // if(i == length - 1) continue;

        // const char* word_gap = "       ";
        // addStr(res, word_gap, &cursor);
    }

    res[cursor] = '\0';
    for(int i = 0; i < length; ++i){
        free(words[i]);
    }

    free(words);
    // printf("real length %i, cursor = %i, arraylength = %i", (int)strlen(res), cursor, lengthOfArray);
    return res;
}