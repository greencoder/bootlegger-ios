//
//  LoanOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 4/27/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol LoanOverlayViewDelegate <NSObject>
- (void)shouldBorrowAmount:(int)amount atRate:(float)rate;
- (void)shouldRepayAmount:(int)amount;
- (void)loanOverlayDidClickOkay;
- (void)loanOverlayDidClickCancel;
@end

@interface LoanOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *loanOneButton;
    IBOutlet WhiteRetroButton *loanTwoButton;
    IBOutlet WhiteRetroButton *loanThreeButton;
    IBOutlet WhiteRetroButton *repayButton;
    IBOutlet WhiteRetroButton *okayButton;
    IBOutlet WhiteRetroButton *cancelButton;
    int chosenLoan;
}

@property (nonatomic, weak) id<LoanOverlayViewDelegate> delegate;
@property (nonatomic, retain) WhiteRetroButton *loanOneButton;
@property (nonatomic, retain) WhiteRetroButton *loanTwoButton;
@property (nonatomic, retain) WhiteRetroButton *loanThreeButton;
@property (nonatomic, retain) WhiteRetroButton *repayButton;
@property (nonatomic, retain) WhiteRetroButton *okayButton;
@property (nonatomic, retain) WhiteRetroButton *cancelButton;
@property int chosenLoan;

- (IBAction)repayClick:(id)sender;
- (IBAction)loanOneButtonClick:(id)sender;
- (IBAction)loanTwoButtonClick:(id)sender;
- (IBAction)loanThreeButtonClick:(id)sender;
- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (void)updateLabelsAndButtons;

@end
