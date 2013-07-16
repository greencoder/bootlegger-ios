//
//  LoanOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 4/27/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "LoanOverlayView.h"

#define LOAN1_AMOUNT 750
#define LOAN2_AMOUNT 1000
#define LOAN3_AMOUNT 1250

#define LOAN_REPAY_AMOUNT 500

#define LOAN1_RATE 5.0
#define LOAN2_RATE 7.0
#define LOAN3_RATE 9.0

@implementation LoanOverlayView

@synthesize loanOneButton = _loanOneButton;
@synthesize loanTwoButton = _loanTwoButton;
@synthesize loanThreeButton = _loanThreeButton;
@synthesize repayButton = _repayButton;
@synthesize okayButton = _okayButton;
@synthesize cancelButton = _cancelButton;
@synthesize chosenLoan = _chosenLoan;

- (IBAction)repayClick:(id)sender
{
    [self.delegate shouldRepayAmount:[(UIButton *)sender tag]];
    [self updateLabelsAndButtons];
}

- (IBAction)loanOneButtonClick:(id)sender
{
    self.chosenLoan = 1;
    self.okayButton.enabled = YES;
    [self.loanOneButton showAsSelected:YES];
    [self.loanTwoButton showAsSelected:NO];
    [self.loanThreeButton showAsSelected:NO];
}

- (IBAction)loanTwoButtonClick:(id)sender
{
    self.chosenLoan = 2;
    self.okayButton.enabled = YES;
    [self.loanOneButton showAsSelected:NO];
    [self.loanTwoButton showAsSelected:YES];
    [self.loanThreeButton showAsSelected:NO];
}

- (IBAction)loanThreeButtonClick:(id)sender
{
    self.chosenLoan = 3;
    self.okayButton.enabled = YES;
    [self.loanOneButton showAsSelected:NO];
    [self.loanTwoButton showAsSelected:NO];
    [self.loanThreeButton showAsSelected:YES];
}

- (IBAction)okayClick:(id)sender
{
    int debtAmount = 0;
    float debtRate = 0;
    
    if (self.chosenLoan == 1) {
        debtAmount = LOAN1_AMOUNT;
        debtRate = LOAN1_RATE;
    }
    else if (self.chosenLoan == 2) {
        debtAmount = LOAN2_AMOUNT;
        debtRate = LOAN2_RATE;
    }
    else if (self.chosenLoan == 3) {
        debtAmount = LOAN3_AMOUNT;
        debtRate = LOAN3_RATE;
    }
    
    [self.delegate shouldBorrowAmount:debtAmount atRate:debtRate];
    [self.delegate loanOverlayDidClickOkay];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate loanOverlayDidClickCancel];
}

- (void)updateLabelsAndButtons
{
    // Set the button visibility
    self.loanOneButton.enabled = (self.player.debt == 0);
    self.loanTwoButton.enabled = (self.player.debt == 0);
    self.loanThreeButton.enabled = (self.player.debt == 0);
    self.repayButton.enabled = (self.player.debt > 0);
    
    if (self.player.debt > 0) {
        self.descriptionLabel.text = [NSString stringWithFormat:@"You owe the shark: $%d", self.player.debt];
    }
    else {
        self.descriptionLabel.text = @"Wanna borrow some quick cash?";
    }
    
    // Set the text of the repay button
    NSString *debt = [NSString stringWithFormat:@"Repay $%d", LOAN_REPAY_AMOUNT];
    self.repayButton.tag = 500;
    
    if (self.player.debt > 0 && self.player.debt < LOAN_REPAY_AMOUNT) {
        debt = [NSString stringWithFormat:@"Repay $%d", self.player.debt];
        self.repayButton.tag = self.player.debt;
    }
    
    self.repayButton.titleLabel.text = debt;
    [self.repayButton setTitle:debt forState:UIControlStateNormal];
    [self.repayButton setTitle:debt forState:UIControlStateSelected];
    
    // The repay button sits in the same place as the first loan button, but
    // that's confusing in IB so we just move it here.
    //self.repayButton.center = self.loanOneButton.center;

    // Decide if the repay button should be enabled
    if (self.player.debt == 0 || self.player.cash == 0) {
        self.repayButton.enabled = NO;
    }
    else if (self.player.cash < LOAN_REPAY_AMOUNT) {
        self.repayButton.enabled = NO;
    }
    else {
        self.repayButton.enabled = YES;
    }

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // the okay button isn't enabled until a choice is made
    self.okayButton.enabled = NO;

    [self updateLabelsAndButtons];

}

@end
