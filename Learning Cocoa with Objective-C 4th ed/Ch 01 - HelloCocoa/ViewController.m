//
//  ViewController.m
//  HelloCocoa
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction) showAlert: (id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello!" message:@"Hello, world!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:close];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
