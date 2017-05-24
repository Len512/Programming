//
//  main.m
//  VowelMovement
//  p223

#import <Foundation/Foundation.h>

typedef void (^ArrayEnumerationBlock)(id, NSUInteger, BOOL *);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Create array of strings and a container for devowelized ones
        NSArray *originalStrings = @[@"Sauerkraut", @"Raygun", @"Big Nerd Ranch", @"Mississippi"];
        NSLog(@"Original strings: %@", originalStrings);
        NSMutableArray *devowelisedStrings = [NSMutableArray array];
        
        // Create a list of characters to be removed from the string
        NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
        
        // Declare the block variable
        // id is a pointer to the current object, NSUInteger is an index to the current object,
        // BOOL is a pointer which defaults to NO. If it changes to YES, it will stop executing the
        // block after the current iteration
        ArrayEnumerationBlock devoweliser;
        
        // Compose a block and assign it to the variable
        devoweliser = ^(id string, NSUInteger i, BOOL *stop){
            
            // Check for uppercase or lowercase y. If there is one, stop execution after current iteration
            NSRange yRange = [string rangeOfString:@"y" options:NSCaseInsensitiveSearch];
            // Did I find a y?
            if (yRange.location != NSNotFound){
                *stop = YES; // Prevent further iterations
                return;      // End this iteration
            }
            
            
            NSMutableString *newString = [NSMutableString stringWithString:string];
            // Iterate over the array of vowels, replacing occurences of each
            // with an empty string
            for (NSString *s in vowels){
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
            }
            [devowelisedStrings addObject:newString];
        }; // End of block assignment
        
        // Iterate over the array with your block
        [originalStrings enumerateObjectsUsingBlock:devoweliser];
        NSLog(@"devowelised strings: %@", devowelisedStrings);
        
    }
    return 0;
}
