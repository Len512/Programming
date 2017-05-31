//
//  VehicleList.m
//  Vehicles
//
//  Created by Len512 on 31/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "VehicleList.h"
#import "Car.h"
#import "Motorcycle.h"
#import "Truck.h"

@implementation VehicleList

+ (VehicleList *) sharedInstance {
    // Declare a static instance variable
    static VehicleList *_vehicleList = nil;
    // Create a token that facilitates only creating this item once
    static dispatch_once_t onceToken;
    // Use Grand Central Dispatch to create a single instance and do any initial setup only once
    dispatch_once(&onceToken, ^{
        // These are only invoked if the onceToken has never been used before
        _vehicleList = [[VehicleList alloc] init];
        _vehicleList.vehicles = [VehicleList initialVehicleList];
    });
    return _vehicleList;
}

#pragma mark - Class method for vehicle creation
+ (NSArray *) initialVehicleList {
    // Initialise mutable array
    NSMutableArray *vehicles = [NSMutableArray array];
    // Crete cars and add them to the array
    // Create a car
    Car *mustang = [Car carWithBrandName:@"Ford" modelName:@"Mustang" modelYear:1968 powerSource:@"gas engine" numberOfDoors:2 convertible:YES hatchback:NO sunroof:NO];
    // Add it to the array
    [vehicles addObject:mustang];
    
    // Create another car
    Car *outback = [Car carWithBrandName:@"Subaru" modelName:@"Outback" modelYear:1999 powerSource:@"gas engine" numberOfDoors:5 convertible:NO hatchback:YES sunroof:NO];
    // Add it to the array
    [vehicles addObject:outback];
    
    // Create another car
    Car *prius = [Car carWithBrandName:@"Toyota" modelName: @"Prius" modelYear:2002 powerSource:@"hybrid engine" numberOfDoors:4 convertible:NO hatchback:YES sunroof:YES];
    // Add it to the array
    [vehicles addObject:prius];
    
    // Create a motorcycle
    Motorcycle *harley = [Motorcycle motorcycleWithBrandName:@"Harley-Davidson" modelName:@"Softail" modelYear:1979 engineNoise:@"Vrrrrrrrrrrrooooom!"];
    [vehicles addObject:harley];
    
    Motorcycle *kawasaki = [Motorcycle motorcycleWithBrandName:@"Kawasaki" modelName:@"Ninja" modelYear:2005 engineNoise:@"Neeeeeeeeeeeeow!"];
    [vehicles addObject:kawasaki];
    
    //Create a truck
    Truck *silverado = [Truck truckWithBrandName:@"Chevrolet" modelName:@"Silverado" modelYear:2011 powerSource:@"gas engine" wheels:4 cargoCapacityCubicFeet:53];
    [vehicles addObject:silverado];
    
    //Create another truck
    Truck *eighteenWheeler = [Truck truckWithBrandName:@"Peterbilt" modelName:@"579" modelYear:2013 powerSource:@"diesel engine" wheels:18 cargoCapacityCubicFeet:408];
    [vehicles addObject:eighteenWheeler];
    
    // Sort the array by the model year
    NSSortDescriptor *modelYearDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"modelYear" ascending:YES];
    [vehicles sortUsingDescriptors:@[modelYearDescriptor]];
    
    return vehicles;
}

@end
