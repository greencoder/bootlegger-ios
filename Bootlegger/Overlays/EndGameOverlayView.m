//
//  EndGameOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "EndGameOverlayView.h"

@implementation EndGameOverlayView

@synthesize endCashLabel = _endCashLabel;
@synthesize endDebtLabel = _endDebtLabel;
@synthesize difficultyBonusLabel = _difficultyBonusLabel;
@synthesize finalScoreLabel = _finalScoreLabel;
@synthesize cash;
@synthesize debt;
@synthesize bonus;
@synthesize final;

- (IBAction)startNewGameClick:(id)sender
{
    [self.delegate endGameOverlayDidClickStartNewGame];
}

- (void)calculateScores
{
    self.cash = self.player.cash;
    self.debt = self.player.debt;
    self.bonus = 0;
    self.final = 0;
    
    NSArray *bonuses = @[@0, @0.125, @0.25];
    
    NSLog(@"difficulty: %d", self.game.difficulty);
    
    if (self.cash > 0) {
        self.bonus = round((self.cash - self.debt) * [bonuses[self.game.difficulty-1] floatValue]);
    }
    
    self.final = self.cash - self.debt + self.bonus;
   
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self calculateScores];
    
    self.endCashLabel.text = [NSString stringWithFormat:@"$%d", self.cash];
    self.endDebtLabel.text = [NSString stringWithFormat:@"$%d", self.debt];
    self.difficultyBonusLabel.text = [NSString stringWithFormat:@"$%d", self.bonus];
    self.finalScoreLabel.text = [NSString stringWithFormat:@"$%d", self.final];

}

@end
