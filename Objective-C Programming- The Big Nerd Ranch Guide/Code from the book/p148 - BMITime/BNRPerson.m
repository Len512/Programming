//
//  BNRPerson.m
//  BMITime
//

#import "BNRPerson.h"

@implementation BNRPerson

- (float) bodyMassIndex {
    float h = [self heightInMeters];
    return [self weightInKilos] / (h * h);
}

@end
