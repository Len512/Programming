//
//  BNRPortfolio.m
//  Stocks
//

#import "BNRPortfolio.h"
#import "BNRStockHolding.h"

@interface BNRPortfolio ()
{
    NSMutableArray *_stockHoldings;
}
@property (nonatomic, copy) NSArray *stockHoldings;
@end

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
- (void) removeStockHolding: (BNRStockHolding *) s {
    if ([_stockHoldings containsObject:s]){
        [_stockHoldings removeObject: s];
    }
}
- (float) valueInDollars {
    float portfolioValue = 0.0;
    for (BNRStockHolding *s in _stockHoldings){
        portfolioValue += [s valueInDollars];
    }
    return portfolioValue;
}
- (NSArray *) topThreeHoldings {
    NSSortDescriptor *vid = [NSSortDescriptor sortDescriptorWithKey:@"valueInDollars" ascending:NO];
    NSArray *holdings = [_stockHoldings sortedArrayUsingDescriptors:@[vid]];
    NSRange three = NSMakeRange(0, MIN(3, [holdings count]));
    return [holdings subarrayWithRange:three];
}
- (NSArray *) sortedHoldingsBySymbol {
    NSSortDescriptor *sym = [NSSortDescriptor sortDescriptorWithKey:@"stockTicker" ascending:YES];
    NSSortDescriptor *vid = [NSSortDescriptor sortDescriptorWithKey:@"valueInDollars" ascending:NO];
    NSArray *holdings = [_stockHoldings sortedArrayUsingDescriptors:@[sym, vid]];
    return holdings;
}
@end
