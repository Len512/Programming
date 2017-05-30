//
//  ViewController.m
//  Tap Me
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Start the game and the timer when the app launches
    [self setUpGame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Initialise the game state
- (void) setUpGame {
    seconds = 15;
    count = 0;
    
    timerLabel.text = [NSString stringWithFormat:@"Time: %li", seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", count];
    
    // target: send message to view controller every 1s,
    // selector: which method to call, userInfo: extra info stored with timer
    // repeat: fire once or repeat?
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
}
#pragma mark - Actions
- (IBAction) buttonPressed {
    count++;
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", count];
}

- (void) subtractTime {
    seconds--;
    timerLabel.text = [NSString stringWithFormat:@"Time: %li", seconds];
    if (seconds == 0){
        [timer invalidate];

//        // UIAlertView deprecated, use UIAlertController instead
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You scored %li points", count] delegate:self cancelButtonTitle:@"Play again" otherButtonTitles:nil];
//        [alert show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You scored %li points", count] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *playAgain = [UIAlertAction actionWithTitle:@"Play again" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self setUpGame];
        }];
        UIAlertAction *close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:playAgain];
        [alertController addAction:close];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
