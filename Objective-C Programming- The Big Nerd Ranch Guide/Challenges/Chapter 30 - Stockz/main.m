//
//  main.m
//  Stockz
//  Challenge

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *stocks = [[NSMutableArray alloc] init];
        // Array
        NSArray *stockVersion = [[NSArray alloc] initWithObjects:@"0.1", @"0.2", nil];
        [stocks addObject:stockVersion];
        // Dictionary
        NSDictionary *stock = @{@"symbol":@"AAPL", @"shares":@"200"};
        [stocks addObject:stock];
        // String
        NSString *description = @"This is a fairly useless description";
        [stocks addObject:description];
        // Data
        NSData *stockData = [NSData dataWithContentsOfFile:@"/tmp/cool.txt"];
        [stocks addObject:stockData];
        // Date
        NSDate *purchased = [NSDate date];
        [stocks addObject:purchased];
        // Integer
        NSNumber *stockID = [NSNumber numberWithInt:113];
        [stocks addObject:stockID];
        // Float
        NSNumber *valueInEuro = [NSNumber numberWithFloat:20.0];
        [stocks addObject:valueInEuro];
        // Boolean
        NSNumber *goodToSell = [NSNumber numberWithBool:NO];
        [stocks addObject:goodToSell];
        
        [stocks writeToFile:@"/tmp/stocksChallenge.plist" atomically:YES];
    
    }
    return 0;
}
