#include "parsers.h"

void substr(const char* src, char* dst, int beg, int end){
    for(int i = beg; i < end; ++i){
        dst[i-beg] = src[i];
    }

    dst[end-beg] = '\0';
}

char** parseToWords(int* length_out, const char* text){
    char** res = NULL;
    int length = 0;
    int i = 0;
    int begin = -1;
 
    while (text[i] != '\0'){
        if((text[i] >= 'a' && text[i] <='z') ||
            (text[i] >= 'A' && text[i] <= 'Z')||
            (text[i] >= '0' && text[i] <= '9')){
            
            if(begin == -1){
                begin = i;
            }
        }

        else if(begin != -1){
            char* word = (char*) malloc(sizeof(char) * (i - begin + 1) );
            // char* word = new char[i - begin + 1];

            substr(text, word, begin, i);

            ++length;
            //printf("realloc\n");
            // char** newres = new char*[length];
            // for(int i = 0; i < length - 1; ++i) newres[i] = res[i];
            // newres[length - 1] = word;
            // delete res;
            // res = newres;
            res = (char**)realloc(res, length * sizeof(char*));
            res[length - 1] = word;
            //printf("%s\n", res[length-1]);
            begin = -1;            
        }
        
        ++i;
    }

    *length_out = length;
    //printf("end of parsing\n");

    return res;
}

char** parseToMorseLetters(int* length_out, const char* text){
    char** res = NULL;
    int length = 0;
    int i = 0;
    int begin = -1;
	printf("text in ptml = %s\n", text);
    while (text[i] != '\0'){
		printf("current char '%c'", text[i]);
        if(text[i] == '.' || text[i] == '-'){
            
            if(begin == -1){
                begin = i;
            }
        }

        else if(begin != -1){
			int memsize = (i - begin + 1) * (sizeof(char));
			printf("first letter i = %i beg = %i, \n", i, begin);
            // char* word = (char*) malloc( memsize );

            char* word = (char*) malloc(memsize);
			printf("after malloc\n");
            substr(text, word, begin, i);

            ++length;
            printf("realloc\n");
            res = (char**)realloc(res, length * sizeof(char*));
            res[length-1] = word;

            printf("%s\n", res[length-1]);
            begin = -1;
        }
        
        ++i;
    }

    *length_out = length;
    printf("end of parsing\n");

    return res;
}

void addStr(char* dst, const char* newstr, int* cursor){
    for(int c = 0; c < strlen(newstr); ++c, ++(*cursor)){
        dst[*cursor] = newstr[c];
    }
}