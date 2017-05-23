//
//  main.m
//  Stringz
//  page 201
//  NSURLConnection is now deprecated

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *dataUrl = @"http://www.google.com/images/logos/ps_logo2.png";
        NSURL *url = [NSURL URLWithString:dataUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *error = nil;
        
        if (!data){
            NSLog(@"fetch failed: %@", [error localizedDescription]);
            return 1;
        }
        NSLog(@"The file is %lu bytes", (unsigned long) [data length]);
        
        
        BOOL written = [data writeToFile:@"/tmp/google.png" options:0 error:&error];
        if (!written){
            NSLog(@"write failed: %@", [error localizedDescription]);
            return 2;
        }
        NSLog(@"Success!");
    }
    return 0;
}
