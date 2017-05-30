//
//  Person.h
//  My First Project
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *firstName;
    NSString *lastName;
    int age;
}
- (void) enterInfo;
- (void) printInfo;
@end
