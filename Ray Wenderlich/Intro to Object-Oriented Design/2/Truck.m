//
//  Truck.m
//  Vehicles
//
//  Created by Len512 on 30/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "Truck.h"

@implementation Truck

#pragma mark - Superclass overrides
- (NSString *) goForward {
    return [NSString stringWithFormat:@"%@ Depress gas pedal.", [self changeGears:@"Drive"]];
}
- (NSString *) stopMoving {
    return [NSString stringWithFormat:@"Depress brake pedal. %@", [self changeGears:@"Park"]];
}
- (NSString *) goBackward {
    NSMutableString *backwardString = [NSMutableString string];
    if (self.cargoCapacityCubicFeet > 100){
        // Sound a backup alarm first
        [backwardString appendFormat:@"Wait for \"%@\", then %@", [self soundBackupAlarm], [self changeGears:@"Reverse"]];
    } else {
        [backwardString appendFormat:@"%@ Depress gas pedal.", [self changeGears:@"Reverse"]];
    }
    return backwardString;
}
- (NSString *) makeNoise {
    if (self.numberOfWheels <= 4){
        return @"Beep beep!";
    } else if (self.numberOfWheels > 4 && self.numberOfWheels <= 8){
        return @"Honk!";
    } else {
        return @"HOOOOOOOONK!";
    }
}
- (NSString *) vehicleDetailsString {
    // Get basic details from superclass
    NSString *basicDetails = [super vehicleDetailsString];
    // Initialise mutable string and add info about truck-specific details
    NSMutableString *truckDetailsBuilder = [NSMutableString string];
    [truckDetailsBuilder appendString:@"\n\nTruck-specific Details: \n\n"];
    [truckDetailsBuilder appendFormat:@"Cargo Capacity: %ld cubic feet", self.cargoCapacityCubicFeet];
    // Create the final string by combining the other two
    NSString *truckDetails = [basicDetails stringByAppendingString:truckDetailsBuilder];
    return truckDetails;
}

#pragma mark - Private methods
- (NSString *) soundBackupAlarm {
    return @"Beep! Beep! Beep!";
}

#pragma mark - Factory method

+ (Truck *) truckWithBrandName: (NSString *) brandName modelName: (NSString *) modelName modelYear: (NSInteger) modelYear powerSource: (NSString *) powerSource wheels: (NSInteger) numberOfWheels cargoCapacityCubicFeet: (NSInteger) cargoCapacityCubicFeet {
    Truck *newTruck = [Truck vehicleWithBrandName:brandName modelName:modelName modelYear:modelYear powerSource:powerSource wheels:numberOfWheels];
    newTruck.cargoCapacityCubicFeet = cargoCapacityCubicFeet;
    return newTruck;
}
@end
