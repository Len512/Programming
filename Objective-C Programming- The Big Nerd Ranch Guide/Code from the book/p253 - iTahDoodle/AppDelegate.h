//
//  AppDelegate.h
//  iTahDoodle
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIWindow *window;
// Pointers to objects the user can see and interact with
// A table view that will display all the tasks to be done
// A text field where you can enter a new task
// A button that will add the new task to the table
@property (nonatomic) UITableView *taskTable;
@property (nonatomic) UITextField *taskField;
@property (nonatomic) UIButton *insertButton;
// An array to store the tasks as strings
@property (nonatomic) NSMutableArray *tasks;

- (void) addTask:(id) sender;

@end
