//
//  MuggingOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 6/4/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "MuggingOverlayView.h"

@implementation MuggingOverlayView

@synthesize cashLostLabel = _cashLostLabel;

- (IBAction)okayClick:(id)sender
{
    [self.delegate muggingOverlayDidClickOkay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // Need to figure out how to calculate the mugging
    int cashLost = [self randomIntFromRangeMin:0 max:self.player.cash];

    // If you have a shotgun, you get money
    if (self.player.offensivePower == 3) {
        cashLost = 0 - cashLost;
    }
    if (self.player.offensivePower == 2) {
        cashLost = round(cashLost * 0.5);
    }
    else {
        cashLost = round(cashLost * 0.7);
    }
    
    if (self.player.cash == 0) {
        self.descriptionLabel.text = @"A punk tried to rob you, but you had no cash to steal.";
        self.cashLostLabel.text = [NSString stringWithFormat:@"You lost no money."];
    }
    
    // If the player has a shotgun, they don't lose any money.
    if (self.player.offensivePower == 3) {
        self.descriptionLabel.text = @"Some thugs tried to mug you, but your shotgun taught them a lesson.";
        self.cashLostLabel.text = [NSString stringWithFormat:@"You stole $%d from them.", abs(cashLost)];
    }
    else if (self.player.offensivePower == 2 || self.player.offensivePower == 1) {
        self.descriptionLabel.text = @"You were carjacked and dropped some cash during the shootout.";
        self.cashLostLabel.text = [NSString stringWithFormat:@"You lost $%d.", cashLost];
    }
    else {
        self.descriptionLabel.text = @"You got jumped in the parking lot. Next time, buy a gun.";
        self.cashLostLabel.text = [NSString stringWithFormat:@"You lost $%d.", cashLost];
    }
    
    [self.delegate muggingOverlayDidGetMugged:cashLost];
}

- (int)randomIntFromRangeMin:(int)min max:(int)max
{
    return round(((float)arc4random() / 0x100000000 * (max - min)) + min);
}

@end
