//
//  BNRForeignStockHolding.m
//  Stocks
//

#import "BNRForeignStockHolding.h"

@implementation BNRForeignStockHolding

- (float) costInDollars {
    float normalCost = [super costInDollars];
    return normalCost * self.conversionRate;
}
- (float) valueInDollars {
    float normalValue = [super valueInDollars];
    return normalValue * self.conversionRate;
}
@end
