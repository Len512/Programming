//
//  main.c
//  PBR
//

#include <stdio.h>
#include <math.h>

void metersToFeetAndInches (double meters, unsigned int *ftPtr, double *inPtr){
    // This function assumes meters is non-negative
    
    // Convert the number of meters into a floating point number of feet
    double rawFeet = meters * 3.281; // e.g. 2.4536
    
    // How many complete feet as an unsigned int?
    unsigned int feet = (unsigned int) floor(rawFeet);
    
    // Store the number of feet at the supplied address
    printf("Storing %u to the address %p\n", feet, ftPtr);
    *ftPtr = feet;
    
    // Calculate inches
    double fractionalFoot = rawFeet - feet;
    double inches = fractionalFoot * 12.0;
    
    // Store the number of inches at the supplied address
    printf("Storing %.2f to the address %p\n", inches, inPtr);
    *inPtr = inches;

}
int main(int argc, const char * argv[]) {
    
//    double pi = 3.14;
//    double integerPart;
//    double fractionPart;
//    
//    // Pass the address of integerPart as an argument
//    fractionPart = modf(pi, &integerPart);
//    
//    // Find the value stored in integerPart
//    printf("integerPart = %.0f, fractionPart = %.2f\n", integerPart, fractionPart);
   
    double meters = 3.0;
    unsigned int feet;
    double inches;
    
    metersToFeetAndInches(meters, &feet, &inches);
    printf("%.1f meters is equal to %d feet and %.1f inches.\n", meters, feet, inches);
    return 0;
}
