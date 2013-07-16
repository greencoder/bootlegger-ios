//
//  DoctorOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/22/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "DoctorOverlayView.h"

#define COST_PER_CLICK 250
#define HEAL_PER_CLICK 10

@implementation DoctorOverlayView

@synthesize healButton = _healButton;
@synthesize currentHealthLabel = _currentHealthLabel;

- (IBAction)healClick:(id)sender
{
    [self.delegate shouldHealNumberOfPoints:HEAL_PER_CLICK forCost:COST_PER_CLICK];
    [self updateButtonsAndLabels];
}

- (IBAction)doneClick:(id)sender
{
    [self.delegate doctorOverlayDidClickDone];
}

- (void)updateButtonsAndLabels
{
    // See if they need the button
    if (self.player.health < 100) {
        self.healButton.enabled = YES;
    }
    else {
        self.healButton.enabled = NO;
    }

    // Make sure they can afford the doctor
    if (self.player.cash < COST_PER_CLICK) {
        self.healButton.enabled = NO;
    }

    self.currentHealthLabel.text = [NSString stringWithFormat:@"Current Health: %d%%",
                                    self.player.health];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self updateButtonsAndLabels];    
}

@end
