//
//  ViewController.h
//  QuoteQuiz
//
//  Created by Len512 on 31/05/2017.
//

#import <UIKit/UIKit.h>
#import "QuizTipViewController.h"

 // Forward declaration: informs the compiler that the Quiz class will be defined later in the compilation process
@class Quiz;

@interface ViewController : UIViewController <QuizTipViewControllerDelegate>

@property (nonatomic, assign) NSInteger quizIndex;
@property (nonatomic, strong) Quiz *quiz;

- (IBAction) ans1Action: (id) sender;
- (IBAction) ans2Action: (id) sender;
- (IBAction) ans3Action: (id) sender;
- (IBAction) startAgain: (id) sender;

@end

