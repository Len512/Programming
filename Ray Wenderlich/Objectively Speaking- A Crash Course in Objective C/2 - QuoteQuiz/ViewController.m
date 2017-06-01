//
//  ViewController.m
//  QuoteQuiz
//
//  Created by Len512 on 31/05/2017.
//

#import "ViewController.h"
#import "Quiz.h"

@interface ViewController ()
// Private interface properties used to provide feedback to user
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *answer1Label;
@property (weak, nonatomic) IBOutlet UILabel *answer2Label;
@property (weak, nonatomic) IBOutlet UILabel *answer3Label;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;
@property (assign, nonatomic) NSInteger answer; // To keep track of the current answer

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Set quizIndex to 999 to tell the app it needs to start at the beginning
    self.quizIndex = 999;
    self.quiz = [[Quiz alloc] initWithQuiz:@"quotes"];
    // start game once app has finished initialising
    [self nextQuizItem];
    self.questionLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:1.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper functions
- (void) quizDone {
    if (self.quiz.correctCount) {
        self.statusLabel.text = [NSString stringWithFormat:@"Quiz Done - Score %ld%%", 100 * self.quiz.correctCount/self.quiz.quizCount];
    } else {
        self.statusLabel.text = @"Quiz Done - Score: 0%";
    }
    [self.startButton setTitle:@"Try Again" forState:UIControlStateNormal];
    self.quizIndex = 999;
}

// Once the player has answered the first question, move on to the next question and present all the questions in sequence.
// To do so, we need a method to get the next quote in line.
- (void) nextQuizItem {
    if (self.quizIndex == 999){
        self.quizIndex = 0;
        self.statusLabel.text = @"";
    } else if ((self.quiz.quizCount-1) > self.quizIndex) {
        self.quizIndex++;
    } else {
        self.quizIndex = 0;
        self.statusLabel.text = @"";
        [self quizDone];
    }
    if (self.quiz.quizCount >= (self.quizIndex +1)) {
        [self.quiz nextQuestion:self.quizIndex];
        self.questionLabel.text = self.quiz.quote;
        self.answer1Label.text = self.quiz.ans1;
        self.answer2Label.text = self.quiz.ans2;
        self.answer3Label.text = self.quiz.ans3;
    } else {
        self.quizIndex = 0;
        [self quizDone];
    }
    // Reset fields for next question
    self.answer1Label.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:1.0];
    self.answer2Label.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:1.0];
    self.answer3Label.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:1.0];
    self.answer1Button.hidden = NO;
    self.answer2Button.hidden = NO;
    self.answer3Button.hidden = NO;
    if (self.quiz.tipCount < 3){
        self.infoButton.hidden = NO;
    } else {
        self.infoButton.hidden = YES;
    }
}

#pragma mark - Button Actions
- (void) checkAnswer {
    if ([self.quiz checkQuestion:self.quizIndex forAnswer:_answer]){
        if (self.answer == 1) {
            self.answer1Label.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 2) {
            self.answer2Label.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 3) {
            self.answer3Label.backgroundColor = [UIColor greenColor];
        }
    } else {
        if (self.answer == 1) {
            self.answer1Label.backgroundColor = [UIColor redColor];
        } else if (self.answer == 2) {
            self.answer2Label.backgroundColor = [UIColor redColor];
        } else if (self.answer == 3) {
            self.answer3Label.backgroundColor = [UIColor redColor];
        }
    }
    self.statusLabel.text = [NSString stringWithFormat:@"Correct: %ld Incorrect: %ld", self.quiz.correctCount, self.quiz.incorrectCount];
    self.answer1Button.hidden = YES;
    self.answer2Button.hidden = YES;
    self.answer3Button.hidden = YES;
    self.startButton.hidden = NO;
    [self.startButton setTitle:@"Next" forState:UIControlStateNormal];
}

- (IBAction) ans1Action: (id) sender {
    self.answer = 1;
    [self checkAnswer];
}
- (IBAction) ans2Action: (id) sender {
    self.answer = 2;
    [self checkAnswer];
}
- (IBAction) ans3Action: (id) sender {
    self.answer = 3;
    [self checkAnswer];
}
- (IBAction) startAgain: (id) sender {
    [self nextQuizItem];
}

#pragma mark - Protocols
- (void) quizTipDidFinish: (QuizTipViewController *) controller {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TipModal"]){
        QuizTipViewController *detailViewController = (QuizTipViewController *) segue.destinationViewController;
        detailViewController.delegate = self;
        detailViewController.tipText = self.quiz.tip;
    }
}
@end
