//
//  GarageOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/18/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol GarageOverlayViewDelegate <NSObject>
- (void)shouldUpgradeVehicleWithInventorySize:(int)size forCost:(int)cost;
- (void)garageOverlayDidClickOkay;
- (void)garageOverlayDidClickCancel;
@end

@interface GarageOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *okayButton;
    IBOutlet WhiteRetroButton *compactButton;
    IBOutlet WhiteRetroButton *sedanButton;
    IBOutlet WhiteRetroButton *truckButton;
    IBOutlet UILabel *currentVehicleLabel;
    int chosenVehicle;
}

@property (nonatomic, retain) WhiteRetroButton *okayButton;
@property (nonatomic, retain) WhiteRetroButton *compactButton;
@property (nonatomic, retain) WhiteRetroButton *sedanButton;
@property (nonatomic, retain) WhiteRetroButton *truckButton;
@property (nonatomic, retain) UILabel *currentVehicleLabel;
@property int chosenVehicle;

- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (IBAction)compactClick:(id)sender;
- (IBAction)sedanClick:(id)sender;
- (IBAction)truckClick:(id)sender;
- (void)resetButtons;

@end
