//
//  BNRPortfolio.h
//  Stocks
//

#import <Foundation/Foundation.h>

@class BNRStockHolding;

@interface BNRPortfolio : NSObject
{
    NSMutableArray *_stockHoldings;
}
@property (nonatomic, copy) NSArray *stockHoldings;

- (void) addStockholding: (BNRStockHolding *) s;
- (float) valueInDollars;

@end
