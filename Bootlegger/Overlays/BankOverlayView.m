//
//  BankOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/19/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BankOverlayView.h"

@implementation BankOverlayView

@synthesize depositButton = _depositButton;
@synthesize depositAllButton = _depositAllButton;
@synthesize withdrawButton = _withdrawButton;
@synthesize withdrawAllButton = _withdrawAllButton;
@synthesize cashLabel = _cashLabel;
@synthesize savingsLabel = _savingsLabel;

- (IBAction)doneClick:(id)sender
{
    [self.delegate bankOverlayDidClickDone];
}

- (IBAction)depositClick:(id)sender
{
    [self.delegate shouldDepositMoney:[(UIButton *)sender tag]];
    [self updateLabelsAndButtons];
}

- (IBAction)depositAllClick:(id)sender
{
    [self.delegate shouldDepositMoney:self.player.cash];
    [self updateLabelsAndButtons];
}

- (IBAction)withdrawClick:(id)sender
{
    [self.delegate shouldWithdrawMoney:[(UIButton *)sender tag]];
    [self updateLabelsAndButtons];
}

- (IBAction)withdrawAllClick:(id)sender
{
    [self.delegate shouldWithdrawMoney:self.player.savings];
    [self updateLabelsAndButtons];
}

- (void)updateLabelsAndButtons
{
    [self.cashLabel setText:[NSString stringWithFormat:@"Your Cash: $%d", self.player.cash]];
    [self.savingsLabel setText:[NSString stringWithFormat:@"Your Savings: $%d", self.player.savings]];
    
    // Configure Deposit Button
    NSString *depositTitle = @"Deposit $500";
    
    if (self.player.cash == 0) {
        self.depositButton.enabled = NO;
        self.depositAllButton.enabled = NO;
        self.depositButton.tag = 0;
    }
    else if (self.player.cash > 500) {
        self.depositButton.enabled = YES;
        self.depositAllButton.enabled = YES;
        self.depositButton.tag = 500;
    }
    else {
        depositTitle = [NSString stringWithFormat:@"Deposit $%d", self.player.cash];
        self.depositButton.enabled = YES;
        self.depositAllButton.enabled = YES;
        self.depositButton.tag = self.player.cash;
    }
    
    self.depositButton.titleLabel.text = depositTitle;
    [self.depositButton setTitle:depositTitle forState:UIControlStateNormal];
    [self.depositButton setTitle:depositTitle forState:UIControlStateNormal];

    // Configure Withdrawal Button
    NSString *withdrawalTitle = @"Withdraw $500";
    
    if (self.player.savings == 0) {
        self.withdrawButton.enabled = NO;
        self.withdrawAllButton.enabled = NO;
        self.withdrawButton.tag = 0;
    }
    else if (self.player.savings > 500) {
        self.withdrawButton.enabled = YES;
        self.withdrawAllButton.enabled = YES;
        self.withdrawButton.tag = 500;
    }
    else {
        withdrawalTitle = [NSString stringWithFormat:@"Withdraw $%d", self.player.savings];
        self.withdrawButton.enabled = YES;
        self.withdrawAllButton.enabled = YES;
        self.withdrawButton.tag = self.player.savings;
    }
    
    self.withdrawButton.titleLabel.text = withdrawalTitle;
    [self.withdrawButton setTitle:withdrawalTitle forState:UIControlStateNormal];
    [self.withdrawButton setTitle:withdrawalTitle forState:UIControlStateNormal];
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self updateLabelsAndButtons];
}

@end
