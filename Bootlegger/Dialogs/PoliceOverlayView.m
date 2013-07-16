//
//  PoliceOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 6/1/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "PoliceOverlayView.h"

@implementation PoliceOverlayView

@synthesize fightButton = _fightButton;
@synthesize runButton = _runButton;

- (IBAction)runClick:(id)sender
{
    // If they have inventory, they need to lose some of it
    if ([self.player countAllItems] > 0)
    {
        // need to drop an item
        NSString *result = [self.player dropRandomItemsWithDifficulty:self.game.difficulty];
        self.descriptionLabel.text = result;
    }
    else
    {
        self.descriptionLabel.text = @"You fled like a coward.";
    }
    
    [self addOkayButton];
}

- (IBAction)fightClick:(id)sender
{
    int damage = [self.player fightPoliceWithDifficulty:self.game.difficulty];
    
    self.player.health -= damage;
    
    // Make sure health doesn't go below zero
    if (self.player.health < 0) {
        self.player.health = 0;
    }
    
    NSString *unit = @"points";
    if (damage == 1) {
        unit = @"point";
    }
    
    if (self.player.health > 0) {
        self.descriptionLabel.text = [NSString stringWithFormat:@"You suffered %d %@ of damage before fighting off the cops.", damage, unit];
    }
    else {
        self.descriptionLabel.text = [NSString stringWithFormat:@"You suffered %d %@ of damage and died in the shootout.", damage, unit];
    }
    
    [self addOkayButton];
}

- (IBAction)okayClick:(id)sender
{
    [self.delegate policeOverlayDidClickOkay];
}

- (void)addOkayButton
{
    self.fightButton.hidden = YES;
    self.runButton.hidden = YES;
    
    CGRect rect = CGRectMake(188,158,125,44);
    WhiteRetroButton *okayButton = [WhiteRetroButton buttonWithType:UIButtonTypeCustom];
    okayButton.frame = rect;
    [okayButton setTitle:@"Okay" forState:UIControlStateNormal];
    [okayButton addTarget:self action:@selector(okayClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:okayButton];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // If they have no guns, they can't fight
    if (self.player.offensivePower == 0) {
        self.fightButton.enabled = NO;
        self.descriptionLabel.text = @"The police are on your tail! Since you have no guns, your only option is to run away.";
    }
    
}

@end
