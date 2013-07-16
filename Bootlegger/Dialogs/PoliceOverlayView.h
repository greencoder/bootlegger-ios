//
//  FightOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 6/1/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol PoliceOverlayViewDelegate <NSObject>
- (void)policeOverlayDidClickOkay;
@end

@interface PoliceOverlayView : BaseOverlayView
{
    IBOutlet WhiteRetroButton *fightButton;
    IBOutlet WhiteRetroButton *runButton;
}

@property (nonatomic, weak) id<PoliceOverlayViewDelegate> delegate;
@property (nonatomic, retain) WhiteRetroButton *fightButton;
@property (nonatomic, retain) WhiteRetroButton *runButton;

- (IBAction)runClick:(id)sender;
- (IBAction)fightClick:(id)sender;
- (IBAction)okayClick:(id)sender;

@end
