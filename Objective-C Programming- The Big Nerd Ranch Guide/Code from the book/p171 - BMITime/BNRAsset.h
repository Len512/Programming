//
//  BNRAsset.h
//  BMITime
//

#import <Foundation/Foundation.h>

@class BNREmployee;
@interface BNRAsset : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic) unsigned int resaleValue;
// pointer instance variable to hold on to the holding employee (from child to parent)
@property (nonatomic, weak) BNREmployee *holder;
@end
