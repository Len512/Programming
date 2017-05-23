//
//  BNRPortfolio.m
//  Stocks
//

#import "BNRPortfolio.h"
#import "BNRStockHolding.h"

@implementation BNRPortfolio
- (void) setStockHoldings: (NSArray *) stockHoldings {
    _stockHoldings = [stockHoldings mutableCopy];
}
- (NSArray *) stockHoldings {
    return [_stockHoldings copy];
}
- (void) addStockholding: (BNRStockHolding *) s {
    if (!_stockHoldings){
        _stockHoldings = [[NSMutableArray alloc] init];
    }
    [_stockHoldings addObject:s];
}
- (float) valueInDollars {
    float portfolioValue = 0.0;
    for (BNRStockHolding *s in _stockHoldings){
        portfolioValue += [s valueInDollars];
    }
    return portfolioValue;
}

@end
