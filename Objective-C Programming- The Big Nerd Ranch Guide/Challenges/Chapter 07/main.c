#include <stdio.h>
#include <math.h>

int main(int argc, const char * argv[]) {
    
    int i = 99;
    while (i >= 0) {
        printf("%i\n", i);
        if (i % 5 == 0){
            printf("Found one!\n");
        }
        i -= 3;
    }
}
