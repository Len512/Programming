//
//  main.m
//  Stocks
//

#import <Foundation/Foundation.h>
#import "BNRStockHolding.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRStockHolding *stock1 = [[BNRStockHolding alloc] init];
        BNRStockHolding *stock2 = [[BNRStockHolding alloc] init];
        BNRStockHolding *stock3 = [[BNRStockHolding alloc] init];
        
        [stock1 setPurchaseSharePrice:2.30];
        [stock1 setCurrentSharePrice:4.50];
        [stock1 setNumberOfShares:40];
        
        [stock2 setPurchaseSharePrice:12.19];
        [stock2 setCurrentSharePrice:10.55];
        [stock2 setNumberOfShares:90];
        
        [stock3 setPurchaseSharePrice:45.10];
        [stock3 setCurrentSharePrice:49.51];
        [stock3 setNumberOfShares:210];
        
        NSMutableArray *stocks = [NSMutableArray array];
        [stocks addObject:stock1];
        [stocks addObject:stock2];
        [stocks addObject:stock3];
        
        for (BNRStockHolding *s in stocks){
            NSLog(@"%.2f", [s valueInDollars]);
        }
    }
    return 0;
}
