//
//  BNRStockHolding.m
//  Stocks
//

#import "BNRStockHolding.h"

@implementation BNRStockHolding

- (float) costInDollars {
    return _purchaseSharePrice * _numberOfShares;
}
- (float) valueInDollars {
    return _currentSharePrice * _numberOfShares;
}

@end
