//
//  NewGameOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "NewGameOverlayView.h"
#import "Constants.h"

@implementation NewGameOverlayView

@synthesize delegate = _delegate;
@synthesize difficultyLabel = _difficultyLabel;
@synthesize lengthLabel = _lengthLabel;
@synthesize okayButton = _okayButton;
@synthesize easyButton = _easyButton;
@synthesize mediumButton = _mediumButton;
@synthesize hardButton = _hardButton;
@synthesize days30Button = _days30Button;
@synthesize days45Button = _days45Button;
@synthesize days60Button = _days60Button;
@synthesize chosenDifficulty = _chosenDifficulty;
@synthesize chosenLength = _chosenLength;

- (IBAction)okayClick:(id)sender
{
    int length;
    if (self.chosenLength == 1) {
        length = 30;
    }
    else if (self.chosenLength == 2) {
        length = 45;
    }
    else {
        length = 60;
    }
    
    [self.delegate shouldStartNewGameWithLength:length difficulty:self.chosenDifficulty];
    [self.delegate newGameOverlayDidClickOkay];
}

- (IBAction)difficultyButtonClick:(id)sender
{
    int tag = [(UIButton *)sender tag];
    [self.easyButton showAsSelected:(tag == 1)];
    [self.mediumButton showAsSelected:(tag == 2)];
    [self.hardButton showAsSelected:(tag == 3)];
    self.chosenDifficulty = tag;
    [self updateLabels];
}

- (IBAction)lengthButtonClick:(id)sender
{
    int tag = [(UIButton *)sender tag];
    [self.days30Button showAsSelected:(tag == 1)];
    [self.days45Button showAsSelected:(tag == 2)];
    [self.days60Button showAsSelected:(tag == 3)];
    self.chosenLength = tag;
    [self updateLabels];
}

- (void)updateLabels
{
    NSArray *difficulties = @[@"Easy", @"Medium", @"Hard"];
    self.difficultyLabel.text = [NSString stringWithFormat:@"Difficulty Level: %@",
                            difficulties[self.chosenDifficulty-1]];

    NSArray *lengths = @[@"30 Days", @"45 Days", @"60 Days"];
    self.lengthLabel.text = [NSString stringWithFormat:@"Game Length: %@",
                            lengths[self.chosenLength-1]];

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // When the new game overlay is displayed, we want to make sure
    // that we delete any saved game and set the in progress flag to no
    [self.delegate shouldResetGame];
    
    self.chosenDifficulty = 1;
    self.chosenLength = 1;

    [self.easyButton showAsSelected:YES];
    [self.days30Button showAsSelected:YES];
    
    [self updateLabels];
    
    self.difficultyLabel.font = FONT_16;
    self.difficultyLabel.textColor = VERY_DARK_GRAY_COLOR;
    
    self.lengthLabel.font = FONT_16;
    self.lengthLabel.textColor = VERY_DARK_GRAY_COLOR;
    
    self.descriptionLabel.font = FONT_14;
    self.descriptionLabel.textColor = DARK_GRAY_COLOR;
}
    
@end
