//
//  main.c
//  PBR
//

#include <stdio.h>
#include <math.h>

void metersToFeetAndInches (double meters, unsigned int *ftPtr, double *inPtr){
    // This function assumes meters is non-negative
    
    // Convert the number of meters into a floating point number of feet
    double rawFeet = meters * 3.281;
    
    // How many complete feet as an unsigned int?
    double feet;
    double inches;
    
    inches = modf(rawFeet, &feet) * 12.0;
    
    if (ftPtr) {
        printf("Storing %.0f to the address %p\n", feet, ftPtr);
        *ftPtr = (unsigned int) feet;
    }
    if (inPtr){
        printf("Storing %.1f to the address %p\n", inches, inPtr);
        *inPtr = (double) inches;
    }
    
}
int main(int argc, const char * argv[]) {
    
    double meters = 3.0;
    unsigned int feet;
    double inches;
    
    metersToFeetAndInches(meters, &feet, &inches);
    printf("%.1f meters is equal to %i feet and %.1f inches.\n", meters, feet, inches);

    return 0;
}
