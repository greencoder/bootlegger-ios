//
//  GunsOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/21/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol GunOverlayViewDelegate <NSObject>
- (void)shouldUpgradeWeaponWithPower:(int)power forCost:(int)cost;
- (void)gunsOverlayDidClickDone;
- (void)gunsOverlayDidClickCancel;
@end

@interface GunsOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *gunButton1;
    IBOutlet WhiteRetroButton *gunButton2;
    IBOutlet WhiteRetroButton *gunButton3;
    IBOutlet WhiteRetroButton *okayButton;
    IBOutlet UILabel *currentGunLabel;
    int chosenGun;
}

@property (nonatomic, retain) WhiteRetroButton *gunButton1;
@property (nonatomic, retain) WhiteRetroButton *gunButton2;
@property (nonatomic, retain) WhiteRetroButton *gunButton3;
@property (nonatomic, retain) WhiteRetroButton *okayButton;
@property (nonatomic, retain) UILabel *currentGunLabel;
@property int chosenGun;

- (void)resetButtons;

@end
