//
//  ButtonRowView.m
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "ButtonRowView.h"
#import "MarketView.h"
#import "Constants.h"
#import "Item.h"
#import "Player.h"

@implementation ButtonRowView

@synthesize delegate = _delegate;
@synthesize player = _player;
@synthesize selectedItem = _selectedItem;
@synthesize buyButton = _buyButton;
@synthesize sellButton = _sellButton;
@synthesize dropButton = _dropButton;
@synthesize pricesButton = _pricesButton;
@synthesize specialButton = _specialButton;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.buyButton = (RetroButton *)[self viewWithTag:MARKET_BUY_TAG];
        self.sellButton = (RetroButton *)[self viewWithTag:MARKET_SELL_TAG];
        self.dropButton = (RetroButton *)[self viewWithTag:MARKET_DROP_TAG];
        self.pricesButton = (RetroButton *)[self viewWithTag:PRICES_TAG];
        self.buyButton.enabled = NO;
        self.sellButton.enabled = NO;
        self.dropButton.enabled = NO;
        self.pricesButton.enabled = YES;
        
        self.selectedItem = nil;
    }
    return self;
}

- (void)updateSpecialButtonWithTitle:(NSString *)newTitle withTag:(int)tagNum
{
    [self.specialButton setTitle:newTitle forState:UIControlStateNormal];
    [self.specialButton setTitle:newTitle forState:UIControlStateHighlighted];
    [self.specialButton setTitle:newTitle forState:UIControlStateSelected];

    self.specialButton.tag = tagNum;
}

- (void)updateButtons
{
    // If a row is not selected, bail
    if (!self.selectedItem) {
        self.buyButton.enabled = NO;
        self.sellButton.enabled = NO;
        self.dropButton.enabled = NO;
        return;
    }
    
    // Enable the buy button if the available quantity is > 0 and they have the cash to buy it
    if (self.selectedItem.isAvailable
        && self.selectedItem.qty > 0
        && (self.player.inventorySpaceAvailable > 0)
        && (self.player.cash >= self.selectedItem.price))
    {
        self.buyButton.enabled = YES;
    }
    else {
        self.buyButton.enabled = NO;
    }
    
    int qty_owned = [self.player countItemsForName:self.selectedItem.name];
    
    // Enable the sell button if the quantity owned > 0 and price > 0
    if (self.selectedItem.isAvailable && qty_owned > 0 && self.selectedItem.price > 0) {
        self.sellButton.enabled = YES;
        self.dropButton.enabled = YES;
    }
    else {
        self.sellButton.enabled = NO;
        self.dropButton.enabled = NO;
    }

    // Enable the drop button if the quantity owned > 0
    if (qty_owned > 0) {
        self.dropButton.enabled = YES;
    }
    else {
        self.dropButton.enabled = NO;
    }
    
}

- (IBAction)pricesClick:(id)sender
{
    [self.delegate didTapPricesButton];
}

- (IBAction)buyClick:(id)sender
{
    [self.delegate didTapBuyButton];
}

- (IBAction)sellClick:(id)sender
{
    [self.delegate didTapSellButton];
}

- (IBAction)dropClick:(id)sender
{
    [self.delegate didTapDropButton];
}

- (IBAction)specialClick:(id)sender
{
    [self.delegate didTapSpecialButton];
}

- (IBAction)gambleClick:(id)sender
{
    [self.delegate didTapGambleButton];
}

@end
