//
//  main.m
//  Challenge - a grocery list
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *groceryList = [NSMutableArray array];
        NSString *bread = @"A loaf of bread";
        NSString *milk = @"A container of milk";
        NSString *butter = @"A stick of butter";
        
        [groceryList addObject:bread];
        [groceryList addObject:milk];
        [groceryList addObject:butter];
        
        NSLog(@"I need to buy: ");
        for (NSString *item in groceryList){
            NSLog(@"%@", item);
        }
        
    }
    return 0;
}
