//
//  NSDate+BNRDateConvenience.h
//  DateMonger
//

#import <Foundation/Foundation.h>

@interface NSDate (BNRDateConvenience)

+ (NSDate *) bnr_midnightForYear: (NSInteger) year ofMonth: (NSInteger) month andDay: (NSInteger) day;

@end
