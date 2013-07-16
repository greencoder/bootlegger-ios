//
//  GunsOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/21/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "GunsOverlayView.h"

#define GUN1_COST  500
#define GUN2_COST 1000
#define GUN3_COST 1500

@implementation GunsOverlayView

@synthesize gunButton1 = _gunButton1;
@synthesize gunButton2 = _gunButton2;
@synthesize gunButton3 = _gunButton3;
@synthesize okayButton = _okayButton;
@synthesize currentGunLabel = _currentGunLabel;
@synthesize chosenGun = _chosenGun;

- (IBAction)doneClick:(id)sender
{
    int thePower = 0;
    int theCost = 0;
    
    if (self.chosenGun == 1) {
        thePower = 1;
        theCost = GUN1_COST;
    }
    else if (self.chosenGun == 2) {
        thePower = 2;
        theCost = GUN2_COST;
    }
    else if (self.chosenGun == 3) {
        thePower = 3;
        theCost = GUN3_COST;
    }
    
    [self.delegate shouldUpgradeWeaponWithPower:thePower forCost:theCost];
    [self.delegate gunsOverlayDidClickDone];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate gunsOverlayDidClickCancel];
}

- (void)resetButtons
{
    self.chosenGun = 0;
    [self.gunButton1 showAsSelected:NO];
    [self.gunButton2 showAsSelected:NO];
    [self.gunButton3 showAsSelected:NO];
    self.okayButton.enabled = NO;
}

- (IBAction)gunButton1Click:(id)sender
{
    self.chosenGun = 1;
    self.okayButton.enabled = YES;
    [self.gunButton1 showAsSelected:YES];
    [self.gunButton2 showAsSelected:NO];
    [self.gunButton3 showAsSelected:NO];
}

- (IBAction)gunButton2Click:(id)sender
{
    self.chosenGun = 2;
    self.okayButton.enabled = YES;
    [self.gunButton1 showAsSelected:NO];
    [self.gunButton2 showAsSelected:YES];
    [self.gunButton3 showAsSelected:NO];
}

- (IBAction)gunButton3Click:(id)sender
{
    self.chosenGun = 3;
    self.okayButton.enabled = YES;
    [self.gunButton1 showAsSelected:NO];
    [self.gunButton2 showAsSelected:NO];
    [self.gunButton3 showAsSelected:YES];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // Update the current vehicle label
    if (self.player.offensivePower == 0) {
        self.currentGunLabel.text = @"Current gun: None";
    }
    else if (self.player.offensivePower == 1) {
        self.currentGunLabel.text = @"Current gun: Pistol";
    }
    else if (self.player.offensivePower == 2) {
        self.currentGunLabel.text = @"Current gun: Rifle";
    }
    else if (self.player.offensivePower == 3) {
        self.currentGunLabel.text = @"Current gun: Shotgun";
    }
    
    // the okay button isn't enabled until a choice is made
    self.okayButton.enabled = NO;
    
    if (self.player.offensivePower < 1 && self.player.cash >= GUN1_COST) {
        self.gunButton1.enabled = YES;
    }
    else {
        self.gunButton1.enabled = NO;
    }
    
    if (self.player.offensivePower < 2 && self.player.cash >= GUN2_COST) {
        self.gunButton2.enabled = YES;
    }
    else {
        self.gunButton2.enabled = NO;
    }
    
    if (self.player.offensivePower < 3 && self.player.cash >= GUN3_COST) {
        self.gunButton3.enabled = YES;
    }
    else {
        self.gunButton3.enabled = NO;
    }
    
}


@end
