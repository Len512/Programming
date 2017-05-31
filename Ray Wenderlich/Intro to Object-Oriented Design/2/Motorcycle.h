//
//  Motorcycle.h
//  Vehicles
//
//  Created by Len512 on 30/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "Vehicle.h"

@interface Motorcycle : Vehicle

@property (nonatomic, strong) NSString *engineNoise;

+ (Motorcycle *) motorcycleWithBrandName: (NSString *) brandName modelName: (NSString *) modelName modelYear: (NSInteger) modelYear engineNoise: (NSString *) engineNoise;

@end
