#include "translation.h"

char* toMorse(struct MorseCode* table, char* text){
    int length;

    char** words = parseToWords(&length, text);
    int symbols = 0;
    for(int i = 0; i < length; ++i){
        symbols += strlen(words[i]);
    }

    int lengthOfArray = symbols * 8 + (length - 1) * 7 + 1;
    char* res = (char*) malloc(sizeof(char) * lengthOfArray);

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
    int* lengthOfWords;
    char*** words = parseToMorseWords(&length, &lengthOfWords, text);
    printf("wordcount : %i\n", length);
    char* res = NULL;
    int resLength = 0;

    int i = 0;
    while(i < length)
    {
        int j = 0;

        while(j < lengthOfWords[i])
        {
            int choice = 0;
            
            while(strcmp(table[choice].code, words[i][j]) != 0) 
            {
                // printf("letter = %c, code = %s, words[i][j] = %s\n", table[choice].letter, table[choice].code, words[i][j]);
                ++choice;
            }
            res = (char*)realloc(res, sizeof(char) * (resLength + 2));
            printf("After realloc\n");
            res[resLength] = table[choice].letter;
            res[resLength+1] = '\0';
            ++resLength;
            ++j;
        }
        
        res = (char*)realloc(res, sizeof(char) * (resLength + 2));
        res[resLength] = ' ';
        res[resLength+1] = '\0';
        ++resLength;

        ++i;
    }

    for(int i = 0; i < length; ++i){
        for(int j = 0; j < lengthOfWords[i]; ++j){
            free(words[i][j]);
        }
    }
    printf("After first free");
    free(lengthOfWords);
    
    return res;
}