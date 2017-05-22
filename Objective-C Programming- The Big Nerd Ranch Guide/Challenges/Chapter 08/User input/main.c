//
//  main.c
//  CountDown
//

#include <stdio.h>
#include <readline/readline.h>
#include <stdlib.h>

int main(int argc, const char * argv[]) {
    
    printf("Where should I start counting? ");
    const char *number = readline(NULL);
    int num = atoi(number);
    while (num >= 0){
        printf("%i\n", num);
        if (num % 5 == 0){
            printf("Found one!\n");
        }
        num -= 3;
    }
    return 0;
}
