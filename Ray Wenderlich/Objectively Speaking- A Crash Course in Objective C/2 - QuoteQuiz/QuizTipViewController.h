//
//  QuizTipViewController.h
//  QuoteQuiz
//
//  Created by Len512 on 31/05/2017.
//

#import <UIKit/UIKit.h>

// Add a protocol so that this class becomes a delegate
@protocol QuizTipViewControllerDelegate;

@interface QuizTipViewController : UIViewController

@property (nonatomic, assign) id <QuizTipViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *tipView;
@property (nonatomic, copy) NSString *tipText;

- (IBAction) doneAction: (id) sender;

@end

// Declare the rest the protocol.
@protocol QuizTipViewControllerDelegate
// This method must be implemented in order to conform with the protocol
- (void) quizTipDidFinish: (QuizTipViewController *) controller;

@end
