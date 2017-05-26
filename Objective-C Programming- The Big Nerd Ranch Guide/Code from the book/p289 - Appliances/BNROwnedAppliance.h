//
//  BNROwnedAppliance.h
//  Appliances
//  p289

#import "BNRAppliance.h"

@interface BNROwnedAppliance : BNRAppliance

@property (readonly) NSSet *ownerNames;

// The designated initialiser
- (instancetype) initWithProductName:(NSString *)pn firstOwnerName: (NSString *) n;
- (void) addOwnerName: (NSString *) n;
- (void) removeOwnerName: (NSString *) n;

@end
