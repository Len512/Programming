//
//  BNRAsset.m
//  BMITime
//

#import "BNRAsset.h"

@implementation BNRAsset

- (NSString *) description {
    return [NSString stringWithFormat:@"<%@: $%u>", self.label, self.resaleValue];
}

- (void) dealloc {
    NSLog(@"deallocating %@", self);
}
@end
