//
//  main.m
//  Obj C Tests
//

#import <Foundation/Foundation.h>
#import <readline/readline.h>
// link the library to the project too, 
// just importing it is not enough
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        const char *number = readline("Where should I start counting? ");
        NSString *start = [NSString stringWithUTF8String:number];
        NSInteger num = [start integerValue];
        
        while (num >= 0){
            NSLog(@"%li", (long) num);
            
            if (num % 5 == 0){
                printf("Found one!\n");
            }
            num -= 3;
        }
    }
    return 0;
}
