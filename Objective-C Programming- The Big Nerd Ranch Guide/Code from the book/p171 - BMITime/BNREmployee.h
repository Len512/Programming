//
//  BNREmployee.h
//  BMITime
//

#import <Foundation/Foundation.h>
#import "BNRPerson.h"

@class BNRAsset;

@interface BNREmployee : BNRPerson
@property (nonatomic) unsigned int employeeID;
@property (nonatomic) NSDate *hireDate;
- (double) yearsOfEmployment;
- (void) addAsset: (BNRAsset *) a;
- (void) removeAsset: (BNRAsset *) a;
- (unsigned int) valueOfAssets;
@end
