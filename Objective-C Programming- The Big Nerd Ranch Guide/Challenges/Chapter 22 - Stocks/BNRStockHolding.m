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
- (NSString *) description {
    return [NSString stringWithFormat:@"Stock holding %@ has a total value of %.2f", self.stockTicker, [self valueInDollars]];
}
@end
