//
//  main.m
//  Stocks
//

#import <Foundation/Foundation.h>
#import "BNRForeignStockHolding.h"
#import "BNRPortfolio.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRPortfolio *portfolio = [[BNRPortfolio alloc] init];
        BNRStockHolding *stock1 = [[BNRStockHolding alloc] init];
        BNRStockHolding *stock2 = [[BNRStockHolding alloc] init];
        BNRForeignStockHolding *stock3 = [[BNRForeignStockHolding alloc] init];
        
        [stock1 setPurchaseSharePrice: 2.30];
        [stock1 setCurrentSharePrice: 4.50];
        [stock1 setNumberOfShares: 40];
        [stock1 setStockTicker:@"XYZ"];
        [portfolio addStockholding:stock1];
        
        [stock2 setPurchaseSharePrice: 12.19];
        [stock2 setCurrentSharePrice: 10.55];
        [stock2 setNumberOfShares: 90];
        [stock2 setStockTicker:@"ABC"];
        [portfolio addStockholding:stock2];
        
        [stock3 setPurchaseSharePrice: 45.10];
        [stock3 setCurrentSharePrice: 49.51];
        [stock3 setNumberOfShares: 210];
        [stock3 setConversionRate: 0.94];
        [stock3 setStockTicker:@"LMN"];
        [portfolio addStockholding:stock3];
        
        for (BNRStockHolding *s in portfolio.stockHoldings){
            NSLog(@"%@", s);
        }
        NSLog(@"Value of portfolio: %.02f", [portfolio valueInDollars]);
        
    }
    return 0;
}
