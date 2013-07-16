//
//  BankOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/19/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol BankOverlayViewDelegate <NSObject>
- (void)shouldDepositMoney:(int)amount;
- (void)shouldWithdrawMoney:(int)amount;
- (void)bankOverlayDidClickDone;
@end

@interface BankOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *depositButton;
    IBOutlet WhiteRetroButton *depositAllButton;
    IBOutlet WhiteRetroButton *withdrawButton;
    IBOutlet WhiteRetroButton *withdrawAllButton;
    IBOutlet UILabel *cashLabel;
    IBOutlet UILabel *savingsLabel;
}

@property (nonatomic, retain) WhiteRetroButton *depositButton;
@property (nonatomic, retain) WhiteRetroButton *depositAllButton;
@property (nonatomic, retain) WhiteRetroButton *withdrawButton;
@property (nonatomic, retain) WhiteRetroButton *withdrawAllButton;
@property (nonatomic, retain) UILabel *cashLabel;
@property (nonatomic, retain) UILabel *savingsLabel;

- (IBAction)doneClick:(id)sender;
- (IBAction)depositClick:(id)sender;
- (IBAction)depositAllClick:(id)sender;
- (IBAction)withdrawClick:(id)sender;
- (IBAction)withdrawAllClick:(id)sender;
- (void)updateLabelsAndButtons;

@end
