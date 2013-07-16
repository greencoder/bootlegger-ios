//
//  PauseOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "PauseOverlayView.h"

@implementation PauseOverlayView

- (IBAction)resumeClick:(id)sender
{
    [self.delegate pauseOverlayDidClickResume];
}

- (IBAction)newGameClick:(id)sender
{
    [self.delegate pauseOverlayDidClickNewGame];
}

@end
