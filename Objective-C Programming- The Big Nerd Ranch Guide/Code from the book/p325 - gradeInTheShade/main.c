//
//  main.c
//  gradeInTheShade
//  p325

#include <stdio.h>
#include <stdlib.h> // malloc(), free()

float averageFloats (float data[], int dataCount){
    float sum = 0.0;
    for (int i = 0; i < dataCount; ++i){
        sum += data[i];
    }
    return sum / dataCount;
}

int main(int argc, const char * argv[]) {

    // Create an array of floats
    // float *gradeBook = malloc(3 * sizeof(float));

    // Declares the array as part of the frame
    float gradeBook[3] = {60.2, 94.5, 81.1};

//    gradeBook[0] = 60.2;
//    gradeBook[1] = 94.5;
//    gradeBook[2] = 81.1;
    
    // Calculate the average
    float average = averageFloats(gradeBook, 3);
    
    // No need to free the array, cleanup happens automatically when the function returns!
//    // Free the array
//    free(gradeBook);
//    gradeBook = NULL;
    
    printf("Average = %.2f\n", average);
    return 0;
}
