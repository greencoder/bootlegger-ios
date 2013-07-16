//
//  SellViewOverlay.m
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "SellOverlayView.h"
#import "Constants.h"
#import "Player.h"

@implementation SellOverlayView

- (IBAction)okayClick:(id)sender
{
    [self.delegate shouldSellItem:item withQuantity:currentQuantity];
    [self.delegate sellOverlayDidClickOkay];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate sellOverlayDidClickCancel];
}

- (IBAction)plusClick:(id)sender
{
    if (currentQuantity < qtyCanSell) {
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
    profitLabel.text = [NSString stringWithFormat:@"Revenue: $%d", (currentQuantity * item.price)];
    self.titleLabel.text = [NSString stringWithFormat:@"Sell %@", item.name];
    currentPriceLabel.text = [NSString stringWithFormat:@"Current price: $%d", item.price];
    availableForSaleLabel.text = [NSString stringWithFormat:@"Items available to sell: %d", qtyCanSell];
}

- (void)calculateFigures
{
    qtyCanSell = [self.player countItemsForName:item.name];
    
    // Limit quantity to 999 for UI Purposes
    if (qtyCanSell > 999) {
        qtyCanSell = 999;
    }
    
    // We default to showing them the maximum they can sell
    currentQuantity = qtyCanSell;
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    item = self.infoDict[@"item"];
    
    quantity.font = FONT_48;
    currentPriceLabel.font = FONT_16;
    availableForSaleLabel.font = FONT_16;
    howManyLabel.font = FONT_16;
    profitLabel.font = FONT_18;
    
    [self calculateFigures];
    [self updateLabels];
    [self updatePlusMinusButtons];
}

- (void)updatePlusMinusButtons
{
    if (currentQuantity < qtyCanSell) {
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
