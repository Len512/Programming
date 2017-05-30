//
//  Motorcycle.m
//  Vehicles
//
//  Created by Len512 on 30/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "Motorcycle.h"

@implementation Motorcycle

#pragma mark - Initialisation
- (id) init {
    if (self = [super init]){
        self.numberOfWheels = 2;
        self.powerSource = @"gas engine";
    }
    return self;
}
#pragma mark - Superclass overrides
- (NSString *) goForward {
    return [NSString stringWithFormat:@"%@ Open throttle.", [self changeGears:@"Forward"]];
}
- (NSString *) goBackward {
    return [NSString stringWithFormat:@"%@ Walk %@ backwards using feet.", [self changeGears:@"Neutral"], self.modelName];
}
- (NSString *) stopMoving {
    return @"Squeeze brakes.";
}
- (NSString *) makeNoise {
    return self.engineNoise;
}
- (NSString *) vehicleDetailsString {
    // Get basic details from superclass
    NSString *basicDetails = [super vehicleDetailsString];
    // Initialise mutable string
    NSMutableString *motorcycleDetailsBuilder = [NSMutableString string];
    [motorcycleDetailsBuilder appendString:@"\n\nMotorcycle-specific Details: \n\n"];
    // Add info about motorcycle-specific features
    [motorcycleDetailsBuilder appendFormat:@"Engine Noise: %@", self.engineNoise];
    // Create the final string by combining basic and motorcycle-specific details
    NSString *motorcycleDetails = [basicDetails stringByAppendingString:motorcycleDetailsBuilder];
    return motorcycleDetails;
}
@end
