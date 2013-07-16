//
//  GambleOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/21/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "GambleOverlayView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@implementation GambleOverlayView

@synthesize highlightView = _highlightView;
@synthesize preventTapView = _preventTapView;
@synthesize buttonArray = _buttonArray;
@synthesize resultsLabel = _resultsLabel;
@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize button5 = _button5;
@synthesize button6 = _button6;
@synthesize button7 = _button7;
@synthesize button8 = _button8;
@synthesize button9 = _button9;
@synthesize button10 = _button10;
@synthesize wagerButton = _wagerButton;
@synthesize chosenNumber = _chosenNumber;
@synthesize winningNumber = _winningNumber;

- (IBAction)doneClick:(id)sender
{
    [self.delegate gambleOverlayDidClickDone];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate gambleOverlayDidClickCancel];
}

- (int)randomIntFromRangeMin:(int)min max:(int)max
{
    return round(((float)arc4random() / 0x100000000 * (max - min)) + min);
}

- (void)finishWager
{
    int winning;
    
    if (self.winningNumber == self.chosenNumber) {
        self.resultsLabel.text = @"You won $5000!";
        winning = 5000;
    }
    else {
        self.resultsLabel.text = @"You lost $500.";
        winning = -500;
    }
    
    [self.delegate shouldCompleteWager:winning];
    
    self.cancelButton.enabled = YES;
    self.doneButton.enabled = YES;
    self.resultsLabel.hidden = NO;

}

- (IBAction)wagerClick:(id)sender
{
    self.wagerButton.enabled = NO;
    self.highlightView.hidden = NO;
    self.cancelButton.enabled = NO;
    self.doneButton.enabled = NO;
    self.preventTapView.hidden = NO;
    
    // Loop over all numbers 3 times
    for (int i = 0; i < 3; i++) {
        
        // On the last pass, we pick a random place to stop at
        int timesToLoop = self.buttonArray.count;
        
        if (i == 2) {
            timesToLoop = [self randomIntFromRangeMin:1 max:self.buttonArray.count];
            self.winningNumber = timesToLoop;
        }
        
        for (int idx = 0; idx < timesToLoop; idx++)
        {
            WhiteRetroButton *button = [self.buttonArray objectAtIndex:idx];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.highlightView.center = button.center;
                [NSThread sleepForTimeInterval:0.1];
                if (idx == (timesToLoop-1) && i == 2) {
                    [self finishWager];
                }
            }];
        }

    }
    
}

- (void)resetOtherButtons:(int)skipTag
{
    for (WhiteRetroButton *button in self.buttonArray) {
        if (button.tag != skipTag) {
            [button showAsSelected:NO];
        }
    }
}

- (IBAction)selectNumberClick:(id)sender
{
    WhiteRetroButton *chosenButton = (WhiteRetroButton *)sender;
    self.chosenNumber = chosenButton.tag;
    [chosenButton showAsSelected:YES];
    [self resetOtherButtons:chosenButton.tag];
    
    if (self.player.cash >= 500) {
        self.wagerButton.enabled = YES;
    }
    else {
        self.resultsLabel.text = @"You don't have enough money.";
        self.resultsLabel.hidden = NO;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.resultsLabel.hidden = YES;
    
    // Draw a view with a pink border
    self.highlightView = [[UIView alloc] initWithFrame:CGRectMake(0,0,62,62)];
    self.highlightView.layer.borderColor = PINK_COLOR.CGColor;
    self.highlightView.layer.borderWidth = 4.0f;
    self.highlightView.center = self.button1.center;
    self.highlightView.hidden = YES;
    [self insertSubview:self.highlightView atIndex:0];
    
    // Draw an invisible view that will display after wagering to prevent
    // tapping on the buttons once the wager starts.
    self.preventTapView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, 450, 150)];
    self.preventTapView.backgroundColor = [UIColor clearColor];
    self.preventTapView.hidden = YES;
    [self addSubview:self.preventTapView];
    
    self.wagerButton.enabled = NO;
    
    self.buttonArray = [NSArray arrayWithObjects:self.button1, self.button2,
                        self.button3, self.button4, self.button5, self.button6,
                        self.button7, self.button8, self.button9, self.button10, nil];

}

@end
