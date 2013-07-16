//
//  BuyOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/1/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOverlayView.h"
#import "Item.h"

@protocol BuyOverlayViewDelegate <NSObject>
- (void)shouldBuyItem:(Item *)item withQuantity:(int)quantity;
- (void)buyOverlayDidClickOkay;
- (void)buyOverlayDidClickCancel;
@end

@interface BuyOverlayView : BaseOverlayView
{
    Item *item;

    IBOutlet UILabel *canAffordLabel;
    IBOutlet UILabel *canFitLabel;
    IBOutlet UILabel *currentPriceLabel;
    IBOutlet UILabel *availableForSaleLabel;
    IBOutlet UILabel *quantity;
    IBOutlet UILabel *howManyLabel;
    IBOutlet UILabel *costLabel;
    IBOutlet UIButton *plusButton;
    IBOutlet UIButton *minusButton;

    int qtyCanAfford;
    int qtyCanFit;
    int qtyCanBuy;
    int currentQuantity;
}

@property (nonatomic, weak) id<BuyOverlayViewDelegate> delegate;

- (void)updatePlusMinusButtons;
- (void)calculateFigures;
- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
