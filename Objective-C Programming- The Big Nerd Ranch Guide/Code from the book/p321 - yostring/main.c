//
//  main.c
//  yostring
//  p321

#include <stdio.h>
#include <stdlib.h> // For malloc/free
#include <string.h> // For strlen

int main(int argc, const char * argv[]) {
 
//    // char x = 0x21; // The character '!'
//    char x = '!';
//    //while (x <= 0x7e) { // The character ~
//    while (x <= '~') {
//        printf("%x is %c\n", x, x);
//        ++x;
//    }

    // Get a pointer to 5 bytes of memory on the heap
//    char *start = malloc(5);
//    // Put L in the first byte
//    *start = 'L';
//    // Put o in the second byte
//    *(start + 1) = 'o';
//    // Put v in the third byte
//    *(start + 2) = 'v';
//    // Put e in the fourth byte
//    *(start + 3) = 'e';
//    // Put zero in the fifth byte
//    *(start + 4) = '\0';
//    start[0] = 'L';
//    start[1] = 'o';
//    start[2] = 'v';
//    start[3] = 'e';
//    start[4] = '\0';
//    
//    // Print out the string and its length
//    printf("%s has %zu characters\n", start, strlen(start));
//    // Print out the third letter
//    // printf("The third letter is %c\n", *(start + 2));
//    printf("The third letter is %c\n", start[2]);
//    // Free the memory so that it can be reused
//    free(start);
//    start = NULL;
    
//    // Claim a chunk of memory big enough to hold three floats
//    float *favourites = malloc(3 * sizeof(float));
//    // Push values into the locations in that buffer
//    favourites[0] = 3.14158;
//    favourites[1] = 2.71828;
//    favourites[2] = 1.41421;
//    // Print out each number on the list
//    for (int i = 0; i < 3; ++i){
//        printf("%.4f is favourite %d\n", favourites[i], i);
//    }
//    // Free the memory so it can be reused
//    free(favourites);
//    favourites = NULL;

//    char *start = "Love";
//    printf("%s has %zu characters \n", start, strlen(start));
//    printf("The third letter is %c \n", start[2]);

    const char *start = "A backslash after two newlines and a tab: \n\n\t\\";
    printf("%s has %zu characters \n", start, strlen(start));
    printf("The third letter is \'%c\'\n", start[2]);
    return 0;
}
