#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char response;
        NSMutableArray *people = [[NSMutableArray alloc] init];
        do {
            Person *newPerson = [[Person alloc] init];
            [newPerson enterInfo];
            [newPerson printInfo];
            [people addObject:newPerson];
            NSLog(@"Do you want to add another person? (y/n)");
            scanf("\n%c", &response);
        } while (response == 'y');
        NSLog(@"Number of people in the database: %li", [people count]);
        for (Person *p in people){
            [p printInfo];
        }
    }
    return 0;
}
