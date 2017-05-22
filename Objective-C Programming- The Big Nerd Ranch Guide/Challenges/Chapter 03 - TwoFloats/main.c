//
//  main.c
//  TwoFloats
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    float float1, float2;
    float1 = 3.14;
    float2 = 42.0;
    
    double aDouble = float1 + float2;
    printf("%f + %f = %g\n", float1, float2, aDouble);
    
    return 0;
}
