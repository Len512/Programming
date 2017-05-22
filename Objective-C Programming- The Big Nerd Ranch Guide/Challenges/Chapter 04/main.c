//
//  main.c
//  Cmd Line Tests
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    int i = 20;
    int j = 25;
    
    int k = (i > j) ? 10 : 5; // k = 5
    if (5 < j - k) { // first expression (5 < 20 true)
        printf("The first expression is true.\n");
    } else if (j > i) { // second expression
        printf("The second expression is true.\n");
    } else {
        printf("Neither expression is true.\n");
    }
    return 0;
}
