//
//  main.m
//  Stringz
//  page 200

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSError *error;
        NSString *filename = @"/etc/resolv.conf";
        NSString *str = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
        if (!str) {
            NSLog(@"read failed: %@", [error localizedDescription]);
        } else {
            NSLog(@"resolv.conf looks like this: %@", str);
        }
    }
    return 0;
}
