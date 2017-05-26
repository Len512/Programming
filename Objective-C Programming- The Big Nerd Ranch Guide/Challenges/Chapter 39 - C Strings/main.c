//
//  main.c
//  Challenge
//  spaceCount

#include <stdio.h>
#include <string.h> // For strlen

int spaceCount(const char *sentence){
    int count = 0;
    for (int i = 0; i < strlen(sentence); ++i){
        if (sentence[i] == ' '){
            ++count;
        }
    }
    return count;
}

int main(int argc, const char * argv[]) {
 
    const char *sentence = "He was not in the cab at the time.";
    printf("\"%s\" has %d spaces\n", sentence, spaceCount(sentence));
    return 0;

}
