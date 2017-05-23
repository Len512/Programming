//
//  main.m
//  DateList
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create three NSData objects
        NSDate *now = [NSDate date];
        NSDate *tomorrow = [now dateByAddingTimeInterval:24.0 * 60.0 * 60.0];
        NSDate *yesterday = [now dateByAddingTimeInterval:-24.0 * 60.0 * 60.0];
        
//        // Create an array containing all three
//        NSArray *dateList = @[now, tomorrow, yesterday];
        
        // Create an empty mutable array
        NSMutableArray *dateList = [NSMutableArray array];
        
        // Add two dates to the array
        [dateList addObject:now];
        [dateList addObject:tomorrow];
        
        // Add yesterday at the beginning of the list
        [dateList insertObject:yesterday atIndex:0];
        
//        // Print a couple of dates
//        NSLog(@"The first date is %@", dateList[0]);
//        NSLog(@"The third date is %@", dateList[2]);
//        
//        // How many dates are in the array?
//        NSLog(@"There are %lu dates", [dateList count]);

        // Iterate over the array
        for (NSDate *d in dateList){
            NSLog(@"Here is a date: %@", d);
        }
//        NSUInteger dateCount = [dateList count];
//        for (int i = 0; i < dateCount; ++i){
//            NSDate *d = dateList[i];
//            NSLog(@"Here is a date: %@", d);
//        }
        // Remove yesterday
        [dateList removeObjectAtIndex:0];
        NSLog(@"Now the first date is %@", dateList[0]);
        
    }
    return 0;
}
