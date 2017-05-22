#include <stdio.h>
#include <limits.h>

int main(int argc, const char * argv[]) {
    
    printf("A float is %zu bytes\n", sizeof(float));
    
    printf("The min value of a short is %d\n", SHRT_MIN);
    printf("The max value of a short is %d\n", SHRT_MAX);
    printf("The max value of an unsigned short is %d\n", USHRT_MAX);
    
}
