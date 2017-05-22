//
//  main.m
//  Hosts
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSHost *myHost = [NSHost currentHost];
        NSString *hostName = [myHost localizedName];
        NSLog(@"My computer's name is %@", hostName);
        
    }
    return 0;
}
