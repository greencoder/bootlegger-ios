//
//  DropOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "DropOverlayView.h"
#import "ButtonRowView.h"
#import "Constants.h"
#import "Player.h"
#import "Item.h"

@implementation DropOverlayView

@synthesize item = _item;

- (IBAction)okayClick:(id)sender
{
    [self.delegate shouldDropItem:self.item withQuantity:currentQuantity];
    [self.delegate dropOverlayDidClickOkay];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate dropOverlayDidClickCancel];
}

- (IBAction)plusClick:(id)sender
{
    if (currentQuantity < qtyCanDrop) {
        currentQuantity += 1;
    }
    [self updateLabels];
    [self updatePlusMinusButtons];
}

- (IBAction)minusClick:(id)sender
{
    if (currentQuantity > 0) {
        currentQuantity -= 1;
    }
    [self updateLabels];
    [self updatePlusMinusButtons];
}

- (void)updateLabels
{
    quantity.text = [NSString stringWithFormat:@"%d", currentQuantity];
    self.titleLabel.text = [NSString stringWithFormat:@"Drop %@", self.item.name];
    availableToDropLabel.text = [NSString stringWithFormat:@"Items available to drop: %d", qtyCanDrop];
}

- (void)calculateFigures
{
    qtyCanDrop = [self.player countItemsForName:self.item.name];
    
    // Limit quantity to 999 for UI Purposes
    if (qtyCanDrop > 999) {
        qtyCanDrop = 999;
    }
    
    // We default to showing them the maximum they can sell
    currentQuantity = qtyCanDrop;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.item = self.infoDict[@"item"];
    
    quantity.font = FONT_48;
    availableToDropLabel.font = FONT_16;
    howManyLabel.font = FONT_16;
    
    [self calculateFigures];
    [self updateLabels];
    [self updatePlusMinusButtons];
}

- (void)updatePlusMinusButtons
{
    if (currentQuantity < qtyCanDrop) {
        plusButton.enabled = YES;
    }
    else {
        plusButton.enabled = NO;
    }
    
    if (currentQuantity > 1) {
        minusButton.enabled = YES;
    }
    else {
        minusButton.enabled = NO;
    }
}

@end
