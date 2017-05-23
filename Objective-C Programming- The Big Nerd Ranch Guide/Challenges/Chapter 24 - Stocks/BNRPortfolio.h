//
//  BNRPortfolio.h
//  Stocks
//

#import <Foundation/Foundation.h>

@class BNRStockHolding;

@interface BNRPortfolio : NSObject

- (void) addStockholding: (BNRStockHolding *) s;
- (void) removeStockHolding: (BNRStockHolding *) s;
- (float) valueInDollars;
- (NSArray *) topThreeHoldings;
- (NSArray *) sortedHoldingsBySymbol;

@end
