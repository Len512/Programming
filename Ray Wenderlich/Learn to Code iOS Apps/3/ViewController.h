//
//  ViewController.h
//  Tap Me
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    NSInteger count; // To hold the number of button taps
    NSInteger seconds; // To holf the number of seconds remaining
    NSTimer *timer; // A timer object
}
- (IBAction) buttonPressed;
@end
