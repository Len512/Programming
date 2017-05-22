//
//  main.m
//  Obj C Tests
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1988];
        [comps setMonth:6];
        [comps setDay:14];
        [comps setHour:4];
        [comps setMinute:15];
        [comps setSecond:0];
        
        NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *dateOfBirth = [g dateFromComponents:comps];
        NSDate *now = [NSDate date];
        
        double secondsIHaveLived = [now timeIntervalSinceDate:dateOfBirth];
        NSLog(@"I have lived %g seconds.", secondsIHaveLived);
    }
    return 0;
}
