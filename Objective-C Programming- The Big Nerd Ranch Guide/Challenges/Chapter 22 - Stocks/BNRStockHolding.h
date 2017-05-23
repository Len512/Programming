//
//  BNRStockHolding.h
//  Stocks
//

#import <Foundation/Foundation.h>

@interface BNRStockHolding : NSObject
@property (nonatomic) float purchaseSharePrice;
@property (nonatomic) float currentSharePrice;
@property (nonatomic) int numberOfShares;
@property (nonatomic, copy) NSString *stockTicker;

- (float) costInDollars;
- (float) valueInDollars;
@end
