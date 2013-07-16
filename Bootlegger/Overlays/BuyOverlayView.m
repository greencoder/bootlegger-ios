//
//  BuyOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/1/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BuyOverlayView.h"
#import "ButtonRowView.h"
#import "Constants.h"
#import "Player.h"

@implementation BuyOverlayView

- (IBAction)okayClick:(id)sender
{
    [self.delegate shouldBuyItem:item withQuantity:currentQuantity];
    [self.delegate buyOverlayDidClickOkay];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate buyOverlayDidClickCancel];
}

- (IBAction)plusClick:(id)sender
{
    if (currentQuantity < qtyCanBuy) {
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
    costLabel.text = [NSString stringWithFormat:@"Cost: $%d", (currentQuantity * item.price)];
    self.titleLabel.text = [NSString stringWithFormat:@"Buy %@", item.name];
    currentPriceLabel.text = [NSString stringWithFormat:@"Current price: $%d", item.price];
    availableForSaleLabel.text = [NSString stringWithFormat:@"Items available: %d", item.qty];
    canAffordLabel.text = [NSString stringWithFormat:@"You can afford %d units", qtyCanAfford];
    canFitLabel.text = [NSString stringWithFormat:@"You have room for %d units", qtyCanFit];
}

- (void)calculateFigures
{
    // Can afford is based on their cash
    qtyCanAfford = round(self.player.cash / item.price);
    
    // Can fit is based on their inventory space
    qtyCanFit = self.player.capacity - [self.player countAllItems];
    
    // Whichever is lower is the max amount they can buy
    if (qtyCanAfford < qtyCanFit) {
        qtyCanBuy = qtyCanAfford;
    }
    else {
        qtyCanBuy = qtyCanFit;
    }

    // Limit can buy to 999 for UI Purposes
    if (qtyCanBuy > 999) {
        qtyCanBuy = 999;
    }
    
    // If the amount they *could* buy is more than what is available,
    // default to what is available.
    if (qtyCanBuy > item.qty) {
        qtyCanBuy = item.qty;
    }
    
    // We start out showing them the maximum they can buy
    currentQuantity = qtyCanBuy;

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    item = self.infoDict[@"item"];
    
    quantity.font = FONT_48;
    currentPriceLabel.font = FONT_16;
    availableForSaleLabel.font = FONT_16;
    canAffordLabel.font = FONT_16;
    canFitLabel.font = FONT_16;
    howManyLabel.font = FONT_16;
    costLabel.font = FONT_18;

    [self calculateFigures];
    [self updateLabels];
    [self updatePlusMinusButtons];
}

- (void)updatePlusMinusButtons
{
    if (currentQuantity < qtyCanBuy) {
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
