//
//  main.c
//  bitwize
//  Challenge

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    unsigned long long everyOddBit = 0;
    for (int i = 0; i < 64; i += 2){
        everyOddBit = everyOddBit | (unsigned long long) 1 << i;
    }
    printf("The odd one: \n");
    printf("Hex: %llx\n", everyOddBit);
    printf("Dec: %llu\n", everyOddBit);
    
    unsigned long long everyEvenBit = 0;
    for (int i = 1; i < 64; i += 2){
        everyEvenBit = everyEvenBit | (unsigned long long) 1 << i;
    }
    printf("The even one: \n");
    printf("Hex: %llx\n", everyEvenBit);
    printf("Dec: %llu\n", everyEvenBit);
    
    return 0;
}
