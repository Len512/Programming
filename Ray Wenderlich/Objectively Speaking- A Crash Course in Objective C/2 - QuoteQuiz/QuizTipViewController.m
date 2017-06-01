//
//  QuizTipViewController.m
//  QuoteQuiz
//
//  Created by Len512 on 31/05/2017.
//

#import "QuizTipViewController.h"

@interface QuizTipViewController ()

@end

@implementation QuizTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Set the tipText field to the tip set in the class variable
    self.tipView.text = self.tipText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) doneAction: (id) sender {
    [self.delegate quizTipDidFinish:self];
}

@end
