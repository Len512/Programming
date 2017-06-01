//
//  Quiz.m
//  QuoteQuiz
//
//  Created by Len512 on 31/05/2017.
//

#import "Quiz.h"

@interface Quiz ()
// Class extension to read and write readonly properties locally inside the implementation
@property (nonatomic, strong) NSString *quote;
@property (nonatomic, strong) NSString *ans1;
@property (nonatomic, strong) NSString *ans2;
@property (nonatomic, strong) NSString *ans3;

@end

@implementation Quiz

#pragma mark - Initialisation
- (instancetype) initWithQuiz:(NSString *)plistName {
    if (self = [super init]){
        NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        self.movieArray = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
        self.quizCount = [self.movieArray count];
        self.tipCount = 0;
    }
    return self;
}

#pragma mark - Public methods
- (void) nextQuestion: (NSUInteger) idx {
    self.quote = [NSString stringWithFormat:@"'%@'", self.movieArray[idx][@"quote"]];
    
    self.ans1 = self.movieArray[idx][@"ans1"];
    self.ans2 = self.movieArray[idx][@"ans2"];
    self.ans3 = self.movieArray[idx][@"ans3"];
    self.tip = self.movieArray[idx][@"tip"];
    
    if (idx == 0) {
        self.correctCount = 0;
        self.incorrectCount = 0;
        self.tipCount = 0;
    }
    
}
- (BOOL) checkQuestion: (NSUInteger) question forAnswer: (NSUInteger) answer {
    NSString *ans = self.movieArray[question] [@"answer"];
    if ([ans intValue] == answer){
        self.correctCount++;
        return YES;
    } else {
        self.incorrectCount++;
        return NO;
    }
}
@end
