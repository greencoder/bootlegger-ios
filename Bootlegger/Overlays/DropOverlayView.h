//
//  DropOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@class Item;

@protocol DropOverlayViewDelegate <NSObject>
- (void)shouldDropItem:(Item *)item withQuantity:(int)quantity;
- (void)dropOverlayDidClickCancel;
- (void)dropOverlayDidClickOkay;
@end

@interface DropOverlayView : BaseOverlayView
{
    Item *item;
    
    IBOutlet UILabel *availableToDropLabel;
    IBOutlet UILabel *quantity;
    IBOutlet UILabel *howManyLabel;
    IBOutlet UIButton *plusButton;
    IBOutlet UIButton *minusButton;
    
    int currentQuantity;
    int qtyCanDrop;
}

@property (nonatomic, weak) id<DropOverlayViewDelegate> delegate;
@property (nonatomic, weak) Item *item;

- (void)updatePlusMinusButtons;
- (void)calculateFigures;
- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end