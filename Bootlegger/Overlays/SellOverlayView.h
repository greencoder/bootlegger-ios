//
//  SellViewOverlay.h
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOverlayView.h"
#import "Item.h"

@protocol SellOverlayViewDelegate <NSObject>
- (void)shouldSellItem:(Item *)item withQuantity:(int)quantity;
- (void)sellOverlayDidClickOkay;
- (void)sellOverlayDidClickCancel;
@end

@interface SellOverlayView : BaseOverlayView
{
    Item *item;
    
    IBOutlet UILabel *currentPriceLabel;
    IBOutlet UILabel *availableForSaleLabel;
    IBOutlet UILabel *quantity;
    IBOutlet UILabel *howManyLabel;
    IBOutlet UILabel *profitLabel;
    IBOutlet UIButton *plusButton;
    IBOutlet UIButton *minusButton;
    
    int currentQuantity;
    int qtyCanSell;
}

@property (nonatomic, weak) id<SellOverlayViewDelegate> delegate;

- (void)updatePlusMinusButtons;
- (void)calculateFigures;
- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end