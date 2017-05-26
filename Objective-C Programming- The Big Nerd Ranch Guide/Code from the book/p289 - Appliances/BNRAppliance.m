//
//  BNRAppliance.m
//  Appliances
//

#import "BNRAppliance.h"

@implementation BNRAppliance

- (instancetype) init {
    return [self initWithProductName:@"Unknown"];
}

- (instancetype) initWithProductName: (NSString *) pn {
    // Call the NSObject's init method
    // Did it return something non-nil?
    if (self = [super init]){
        // Set the product name
        _productName = [pn copy];
        // Give voltage a starting value
        _voltage = 120;
    }
    // Return a pointer to the new object
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<%@: %d volts>", self.productName, self.voltage];
}
@end
