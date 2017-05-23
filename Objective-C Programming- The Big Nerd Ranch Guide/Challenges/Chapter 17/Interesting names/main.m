//
//  main.m
//  Challenge - interesting names
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Read in files as strings (ignoring the possibility of an error)
        NSString *nameString = [NSString stringWithContentsOfFile:@"/usr/share/dict/propernames" encoding:NSUTF8StringEncoding error:NULL];
        NSString *regularWords = [NSString stringWithContentsOfFile:@"/usr/share/dict/words" encoding:NSUTF8StringEncoding error:NULL];
        // Break them into arrays of strings
        NSArray *names = [nameString componentsSeparatedByString:@"\n"];
        NSArray *words = [regularWords componentsSeparatedByString:@"\n"];
        
        // Go through the words array one string at a time
        for (NSString *w in words){
            // Look for n in names in a case-insensitive manner but leave out those regular words that are names
            for (NSString *n in names){
                if (([w caseInsensitiveCompare:n] == NSOrderedSame) && ([w compare:n] != NSOrderedSame)){
                    NSLog(@"Found %@ and %@", w, n);
                }
            }
        }
    }
    return 0;
}
