//
//  BNREmployee.m
//  BMITime
//

#import "BNREmployee.h"

@implementation BNREmployee

- (double) yearsOfEmployment {
    // Do I have a non-nil hireDate?
    if (self.hireDate){
        // NSTimeInterval is the same as double
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate:self.hireDate];
        return secs / 31557600.0; // seconds per year
    } else {
        return 0;
    }
}
- (float) bodyMassIndex {
    float normalBMI = [super bodyMassIndex];
    return normalBMI * 0.9;
}
- (NSString *) description {
    return [NSString stringWithFormat:@"<Employee %d>", self.employeeID];
}
@end
