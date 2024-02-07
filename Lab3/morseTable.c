#include "morseTable.h"

void setVals(struct MorseCode* m, char letter, const char* code){
    (*m).letter = letter; strcpy((*m).code, code);
}

struct MorseCode* getTable(){
    struct MorseCode* arr = (struct MorseCode*) malloc(sizeof(struct MorseCode) * 36);
    //struct MorseCode* arr = new MorseCode[36];
    setVals(&arr[0],  'a', ".-");
    setVals(&arr[1],  'b', "-...");
    setVals(&arr[2],  'c', "-.-.");
    setVals(&arr[3],  'd', "-..");
    setVals(&arr[4],  'e', ".");
    setVals(&arr[5],  'f', "..-.");
    setVals(&arr[6],  'g', "--.");
    setVals(&arr[7],  'h', "....");
    setVals(&arr[8],  'i', "..");
    setVals(&arr[9],  'j', ".---");
    setVals(&arr[10], 'k', "-.-");
    setVals(&arr[11], 'l', ".-..");
    setVals(&arr[12], 'm', "--");
    setVals(&arr[13], 'n', "-.");
    setVals(&arr[14], 'o', "---");
    setVals(&arr[15], 'p', ".--.");
    setVals(&arr[16], 'q', "--.-");
    setVals(&arr[17], 'r', ".-.");
    setVals(&arr[18], 's', "...");
    setVals(&arr[19], 't', "-");
    setVals(&arr[20], 'u', "..-");
    setVals(&arr[21], 'v', "...-");
    setVals(&arr[22], 'w', ".--");
    setVals(&arr[23], 'x', "-..-");
    setVals(&arr[24], 'y', "-.--");
    setVals(&arr[25], 'z', "--..");
    setVals(&arr[26], '1', ".----");
    setVals(&arr[27], '2', "..---");
    setVals(&arr[28], '3', "...--");
    setVals(&arr[29], '4', "....-");
    setVals(&arr[30], '5', ".....");
    setVals(&arr[31], '6', "-....");
    setVals(&arr[32], '7', "--...");
    setVals(&arr[33], '8', "---..");
    setVals(&arr[34], '9', "----.");
    setVals(&arr[35], '0', "-----");

    return arr;
}