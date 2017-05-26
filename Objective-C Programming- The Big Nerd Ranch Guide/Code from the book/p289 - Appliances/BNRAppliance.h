//
//  BNRAppliance.h
//  Appliances
//

#import <Foundation/Foundation.h>

@interface BNRAppliance : NSObject

@property (nonatomic, copy) NSString *productName;
@property (nonatomic) int voltage;

// The designated initialiser
- (instancetype) initWithProductName: (NSString *) pn;

@end
