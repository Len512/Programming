//
//  main.m
//  BMITime
//
// page 148

#import <Foundation/Foundation.h>
#import "BNREmployee.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create an instance of BNREmployee
        BNREmployee *mikey = [[BNREmployee alloc] init];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:2];
        [comps setMonth:8];
        [comps setYear:2010];
        [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // Give the instance variables interesting values using setters
        mikey.weightInKilos = 96;
        mikey.heightInMeters = 1.8;
        mikey.employeeID = 12;
        mikey.hireDate = [gregorian dateFromComponents:comps];
        
        // Log the instance variables using the getters
        NSLog(@"mikey is %.2f meters tall and weighs %d kilograms", mikey.heightInMeters, mikey.weightInKilos);
        NSLog(@"%@ hired on %@", mikey, mikey.hireDate);
        
        // Log some values using custom methods
        float bmi = [mikey bodyMassIndex];
        double years = [mikey yearsOfEmployment];
        NSLog(@"mikey has a BMI of %.2f and has worked with us for %.2f years", bmi, years);
    }
    return 0;
}
