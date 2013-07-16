//
//  FooterView.m
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "FooterView.h"
#import "Constants.h"
#import "Player.h"

@implementation FooterView

@synthesize player = _player;

- (void)updateLabels
{
    health.text = [NSString stringWithFormat:@"%d", self.player.health];
    cash.text = [NSString stringWithFormat:@"$%d", self.player.cash];
    debt.text = [NSString stringWithFormat:@"$%d", self.player.debt];
    savings.text = [NSString stringWithFormat:@"$%d", self.player.savings];
    inventory.text = [NSString stringWithFormat:@"%d/%d", [self.player countAllItems],
                    self.player.capacity];
    
    // Make sure to call setNeedsDisplay so that we update any label spacing as
    // the values in the label get longer.
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    cashLabel.font = FONT_16;
    cashLabel.textColor = [UIColor whiteColor];
    [cashLabel sizeToFit];
    
    cash.font = FONT_16;
    cash.textColor = YELLOW_COLOR;
    [cash sizeToFit];
    
    debtLabel.font = FONT_16;
    debtLabel.textColor = [UIColor whiteColor];
    [debtLabel sizeToFit];
    
    debt.font = FONT_16;
    debt.textColor = YELLOW_COLOR;
    [debt sizeToFit];
   
    savingsLabel.font = FONT_16;
    savingsLabel.textColor = [UIColor whiteColor];
    [savingsLabel sizeToFit];
    
    savings.font = FONT_16;
    savings.textColor = YELLOW_COLOR;
    [savings sizeToFit];
    
    health.font = FONT_16;
    health.textColor = YELLOW_COLOR;
    [health sizeToFit];

    inventoryLabel.font = FONT_16;
    inventoryLabel.textColor = [UIColor whiteColor];
    [inventoryLabel sizeToFit];

    inventory.font = FONT_16;
    inventory.textColor = YELLOW_COLOR;
    [inventory sizeToFit];
    
    // Move values next to their label after the font is rendered
    CGRect frame;
    float new_x;
    
    frame = cash.frame;
    new_x = cashLabel.frame.size.width + cashLabel.frame.origin.x + MARGIN;
    frame.origin.x = new_x;
    cash.frame = frame;

    frame = debtLabel.frame;
    new_x = cash.frame.size.width + cash.frame.origin.x + (MARGIN * 3);
    frame.origin.x = new_x;
    debtLabel.frame = frame;
    
    frame = debt.frame;
    new_x = debtLabel.frame.size.width + debtLabel.frame.origin.x + MARGIN;
    frame.origin.x = new_x;
    debt.frame = frame;

    frame = savingsLabel.frame;
    new_x = debt.frame.size.width + debt.frame.origin.x + (MARGIN * 3);
    frame.origin.x = new_x;
    savingsLabel.frame = frame;    
    
    frame = savings.frame;
    new_x = savingsLabel.frame.size.width + savingsLabel.frame.origin.x + MARGIN;
    frame.origin.x = new_x;
    savings.frame = frame;

    frame = heart.frame;
    new_x = health.frame.origin.x - frame.size.width - MARGIN;
    frame.origin.x = new_x;
    heart.frame = frame;
    
    frame = inventory.frame;
    new_x = heart.frame.origin.x - frame.size.width - (MARGIN * 2);
    frame.origin.x = new_x;
    inventory.frame = frame;
    
    frame = inventoryLabel.frame;
    new_x = inventory.frame.origin.x - frame.size.width - MARGIN;
    frame.origin.x = new_x;
    inventoryLabel.frame = frame;
    
}

@end
