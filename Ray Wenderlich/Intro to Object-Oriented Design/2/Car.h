//
//  Car.h
//  Vehicles
//
//  Created by Len512 on 30/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "Vehicle.h"

@interface Car : Vehicle

@property (nonatomic, assign) BOOL isConvertible;
@property (nonatomic, assign) BOOL isHatchback;
@property (nonatomic, assign) BOOL hasSunroof;
@property (nonatomic, assign) NSInteger numberOfDoors;
// Factory method
+ (Car *) carWithBrandName: (NSString *)brandName modelName:(NSString *)modelName modelYear:(NSInteger) modelYear powerSource:(NSString *)powerSource numberOfDoors:(NSInteger)numberOfDoors convertible: (BOOL) isConvertible hatchback: (BOOL) isHatchback sunroof: (BOOL) hasSunroof;
@end
