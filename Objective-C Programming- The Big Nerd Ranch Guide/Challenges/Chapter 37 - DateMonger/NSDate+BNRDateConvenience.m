//
//  NSDate+BNRDateConvenience.m
//  DateMonger
//

#import "NSDate+BNRDateConvenience.h"

@implementation NSDate (BNRDateConvenience)

+ (NSDate *) bnr_midnightForYear: (NSInteger) year ofMonth: (NSInteger) month andDay: (NSInteger) day {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];
    [comp setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [calendar dateFromComponents:comp];
}

@end
