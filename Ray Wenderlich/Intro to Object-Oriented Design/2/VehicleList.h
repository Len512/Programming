//
//  VehicleList.h
//  Vehicles
//
//  Created by Len512 on 31/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleList : NSObject

// The list of vehicles
@property (nonatomic, strong) NSArray *vehicles;

// Singleton instance
+ (VehicleList *) sharedInstance;

@end
