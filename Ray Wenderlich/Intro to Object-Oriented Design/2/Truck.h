//
//  Truck.h
//  Vehicles
//
//  Created by Len512 on 30/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "Vehicle.h"

@interface Truck : Vehicle

@property (nonatomic, assign) NSInteger cargoCapacityCubicFeet;

// Factory method
+ (Truck *) truckWithBrandName: (NSString *) brandName modelName: (NSString *) modelName modelYear: (NSInteger) modelYear powerSource: (NSString *) powerSource wheels: (NSInteger) numberOfWheels cargoCapacityCubicFeet: (NSInteger) cargoCapacityCubicFeet;

@end
