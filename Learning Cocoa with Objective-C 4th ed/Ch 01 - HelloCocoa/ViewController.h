//
//  ViewController.h
//  HelloCocoa
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *helloButton;

- (IBAction) showAlert: (id)sender;

@end

