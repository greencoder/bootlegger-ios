//
//  LastDayOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/25/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "LastDayOverlayView.h"

@implementation LastDayOverlayView

- (IBAction)doneClick:(id)sender
{
    [self.delegate lastDayOverlayDidClickDone];
}

@end
