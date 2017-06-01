//
//  ViewController.h
//  QuoteGen
//
//  Created by Len512 on 31/05/2017.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSArray *movieQuotes;
@property (nonatomic, strong) IBOutlet UITextView *quoteText;
@property (nonatomic, strong) IBOutlet UISegmentedControl *quoteOpt;

- (IBAction) quoteButtonTapped: (id) sender;
@end

