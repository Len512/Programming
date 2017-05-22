#include <stdio.h>
#include <stdlib.h>

typedef struct {
    float heightInMeters;
    int weightInKilos;
} Person;

float bodyMassIndex (Person *p){
    return p->weightInKilos / (p->heightInMeters * p->heightInMeters);
}
int main(int argc, const char * argv[]) {
    
    // Allocate memory for one Person structure
    Person *mikey = (Person *) malloc(sizeof(Person));
    
    // Fill in two members of the structure
    mikey->heightInMeters = 1.7;
    mikey->weightInKilos = 96;
    
    // Print out the BMI of the original Person
    float mikeyBMI = bodyMassIndex(mikey);
    printf("mikey has a BMI of %f\n", mikeyBMI);
    
    // Let the memory be recycled
    free(mikey);
    
    // Forget where it was
    mikey = NULL;
    
    return 0;
}
