//
//  main.m
//  DateMonger
//  Challenge

#import <Foundation/Foundation.h>
#import "NSDate+BNRDateConvenience.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDate *date = [NSDate bnr_midnightForYear:2017 ofMonth:6 andDay:15];
        NSLog(@"Midnight of 15/6/2017: %@", date);
    }
    return 0;
}
