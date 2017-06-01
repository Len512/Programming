//
//  ViewController.m
//  QuoteGen
//
//  Created by Len512 on 31/05/2017.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = @[
                      @"Live and let live",
                      @"Don't cry over spilt milk",
                      @"Always look on the bright side of life",
                      @"Nobody's perfect",
                      @"Can't see the woods for the trees",
                      @"Better to have loved and lost then not loved at all",
                      @"The early bird catches the worm",
                      @"As slow as a wet week"
                      ];
    // Load movie quotes
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface methods (Buttons)
- (IBAction) quoteButtonTapped: (id) sender {
    if (self.quoteOpt.selectedSegmentIndex == 2){
        // 1.1 Get number of rows in array
        NSUInteger array_tot = [self.myQuotes count];
        // 1.2 Initialise string for concatenated quotes
        NSString *allMyQuotes = @"";
        NSString *myQuote = nil;
        // 1.3 Iterate through the array
        for (int x = 0; x < array_tot; x++){
            myQuote = self.myQuotes[x];
            allMyQuotes = [NSString stringWithFormat:@"%@\n%@", allMyQuotes, myQuote];
        }
        self.quoteText.text = [NSString stringWithFormat:@"%@", allMyQuotes];
    } else {
        // 2.1 Determine category
        NSString *selectedCategory = @"classic";
        if (self.quoteOpt.selectedSegmentIndex == 1){
            selectedCategory = @"modern";
        }
        // 2.2 Filter array by category using predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        // 2.3
        NSUInteger array_tot = [filteredArray count];
        // 2.4 Array has quotes in it
        if (array_tot > 0) {
            // 2.5
            NSUInteger index = arc4random() % array_tot;
            // 2.6
            NSString *quote =filteredArray[index][@"quote"];
            // 2.7
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if ([source length] != 0){
                quote = [NSString stringWithFormat:@"%@\n\n(%@)", quote, source];
            }
            // 2.8 Customise quote based on category
            if ([selectedCategory isEqualToString:@"classic"]){
                quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@", quote];
            } else {
                quote = [NSString stringWithFormat:@"Movie Quote: \n\n%@", quote];
            }
            if ([source hasPrefix:@"Harry"]){
                quote = [NSString stringWithFormat:@"HARRY ROCKS!!\n\n%@", quote];
            }
            // 2.9
            self.quoteText.text = quote;
            // 2.10 Update row to indicate that it has been displayed
            NSUInteger movie_array_tot = [self.movieQuotes count];
            NSString *quote1 = filteredArray[index][@"quote"];
            for (int i = 0; i < movie_array_tot; i++){
                NSString *quote2 = self.movieQuotes[i][@"quote"];
                if ([quote1 isEqualToString:quote2]){
                    NSMutableDictionary *itemAtIndex = (NSMutableDictionary *)self.movieQuotes[i];
                    itemAtIndex[@"source"] = @"DONE";
                }
            }
        } else {
            self.quoteText.text = [NSString stringWithFormat:@"No quotes to display!"];
        }
        
    }
    
}
@end
