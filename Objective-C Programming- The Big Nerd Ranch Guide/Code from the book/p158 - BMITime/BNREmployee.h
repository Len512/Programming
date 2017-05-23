//
//  BNREmployee.h
//  BMITime
//

#import <Foundation/Foundation.h>
#import "BNRPerson.h"

@class BNRAsset;

@interface BNREmployee : BNRPerson
{
    NSMutableArray *_assets;
}

@property (nonatomic) unsigned int employeeID;
@property (nonatomic) unsigned int officeAlarmCode;
@property (nonatomic) NSDate *hireDate;
- (double) yearsOfEmployment;
- (void) addAsset: (BNRAsset *) a;
- (unsigned int) valueOfAssets;
@end
