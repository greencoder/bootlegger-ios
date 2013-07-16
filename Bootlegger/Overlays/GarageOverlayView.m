//
//  GarageOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/18/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "GarageOverlayView.h"

#define VEHICLE1_CAPACITY 30
#define VEHICLE2_CAPACITY 60
#define VEHICLE3_CAPACITY 90

#define VEHICLE1_COST 1250
#define VEHICLE2_COST 2500
#define VEHICLE3_COST 5000

@implementation GarageOverlayView

@synthesize okayButton = _okayButton;
@synthesize compactButton = _compactButton;
@synthesize sedanButton = _sedanButton;
@synthesize truckButton = _truckButton;
@synthesize chosenVehicle = _chosenVehicle;
@synthesize currentVehicleLabel = _currentVehicleLabel;

- (IBAction)okayClick:(id)sender
{
    int theSize = 0;
    int theCost = 0;
    
    if (self.chosenVehicle == 1) {
        theSize = VEHICLE1_CAPACITY;
        theCost = VEHICLE1_COST;
    }
    else if (self.chosenVehicle == 2) {
        theSize = VEHICLE2_CAPACITY;
        theCost = VEHICLE2_COST;
    }
    else if (self.chosenVehicle == 3) {
        theSize = VEHICLE3_CAPACITY;
        theCost = VEHICLE3_COST;
    }

    [self.delegate shouldUpgradeVehicleWithInventorySize:theSize forCost:theCost];
    [self.delegate garageOverlayDidClickOkay];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate garageOverlayDidClickCancel];
}

- (void)resetButtons
{
    self.chosenVehicle = 0;
    [self.compactButton showAsSelected:NO];
    [self.sedanButton showAsSelected:NO];
    [self.truckButton showAsSelected:NO];
}

- (IBAction)compactClick:(id)sender
{
    self.chosenVehicle = 1;
    self.okayButton.enabled = YES;
    [self.compactButton showAsSelected:YES];
    [self.sedanButton showAsSelected:NO];
    [self.truckButton showAsSelected:NO];
}

- (IBAction)sedanClick:(id)sender
{
    self.chosenVehicle = 2;
    self.okayButton.enabled = YES;
    [self.compactButton showAsSelected:NO];
    [self.sedanButton showAsSelected:YES];
    [self.truckButton showAsSelected:NO];
}

- (IBAction)truckClick:(id)sender
{
    self.chosenVehicle = 3;
    self.okayButton.enabled = YES;
    [self.compactButton showAsSelected:NO];
    [self.sedanButton showAsSelected:NO];
    [self.truckButton showAsSelected:YES];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // Update the current vehicle label
    if (self.player.capacity < VEHICLE1_CAPACITY) {
        self.currentVehicleLabel.text = @"Current vehicle: None";
    }
    else if (self.player.capacity == VEHICLE1_CAPACITY) {
        self.currentVehicleLabel.text = @"Current vehicle: Compact";
    }
    else if (self.player.capacity == VEHICLE2_CAPACITY) {
        self.currentVehicleLabel.text = @"Current vehicle: Sedan";
    }
    else {
        self.currentVehicleLabel.text = @"Current vehicle: Truck";
    }
    
    // the okay button isn't enabled until a choice is made
    self.okayButton.enabled = NO;

    // conditions:
    // capacity less than 30 and they have 5k  - enable compact
    // capacity less than 60 and they have 10k - enable sedan
    // capacity less than 90 and they have 15k - enable minivan
    
    if (self.player.capacity < VEHICLE1_CAPACITY && self.player.cash >= VEHICLE1_COST) {
        self.compactButton.enabled = YES;
    }
    else {
        self.compactButton.enabled = NO;
    }
    
    if (self.player.capacity < VEHICLE2_CAPACITY && self.player.cash >= VEHICLE2_COST) {
        self.sedanButton.enabled = YES;
    }
    else {
        self.sedanButton.enabled = NO;
    }
    
    if (self.player.capacity < VEHICLE3_CAPACITY && self.player.cash >= VEHICLE3_COST) {
        self.truckButton.enabled = YES;
    }
    else {
        self.truckButton.enabled = NO;
    }

}


@end
