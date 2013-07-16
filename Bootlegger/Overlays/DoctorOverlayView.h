//
//  DoctorOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/22/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol DoctorOverlayViewDelegate <NSObject>
- (void)shouldHealNumberOfPoints:(int)numPoints forCost:(int)cost;
- (void)doctorOverlayDidClickDone;
@end

@interface DoctorOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *healButton;
    IBOutlet UILabel *currentHealthLabel;
}

@property (nonatomic, retain) WhiteRetroButton *healButton;
@property (nonatomic, retain) UILabel *currentHealthLabel;

- (IBAction)healClick:(id)sender;
- (IBAction)doneClick:(id)sender;
- (void)updateButtonsAndLabels;

@end
