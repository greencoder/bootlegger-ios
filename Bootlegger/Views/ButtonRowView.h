//
//  ButtonRowView.h
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetroButton.h"

@class MainViewController;
@class Player;
@class Item;

@protocol ButtonRowViewDelegate <NSObject>
- (void)didTapBuyButton;
- (void)didTapSellButton;
- (void)didTapDropButton;
- (void)didTapPricesButton;
- (void)didTapSpecialButton;
- (void)didTapGambleButton;
@end

@interface ButtonRowView : UIView
{
    id delegate;
    Player *player;
    Item *selectedItem;
    IBOutlet RetroButton *buyButton;
    IBOutlet RetroButton *sellButton;
    IBOutlet RetroButton *dropButton;
    IBOutlet RetroButton *pricesButton;
    IBOutlet RetroButton *specialButton;
}

@property (nonatomic, weak) id<ButtonRowViewDelegate> delegate;
@property (nonatomic, weak) Player *player;
@property (nonatomic, weak) Item *selectedItem;
@property (nonatomic, retain) RetroButton *buyButton;
@property (nonatomic, retain) RetroButton *sellButton;
@property (nonatomic, retain) RetroButton *dropButton;
@property (nonatomic, retain) RetroButton *pricesButton;
@property (nonatomic, retain) RetroButton *specialButton;

- (void)updateButtons;
- (IBAction)buyClick:(id)sender;
- (IBAction)sellClick:(id)sender;
- (void)updateSpecialButtonWithTitle:(NSString *)newTitle withTag:(int)tagNum;

@end
