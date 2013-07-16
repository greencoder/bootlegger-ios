//
//  TravelOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "TravelOverlayView.h"

@implementation TravelOverlayView

- (IBAction)okayClick:(id)sender
{
    [self.delegate travelOverlayDidClickOkay];
    NSString *newLocation = self.infoDict[@"location"];
    [self.delegate shouldTravelToLocation:newLocation];
}

- (IBAction)cancelClick:(id)sender
{
    [self.delegate travelOverlayDidClickCancel];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSString *newLocation = self.infoDict[@"location"];
    self.descriptionLabel.text = [self.descriptionLabel.text stringByReplacingOccurrencesOfString:@"LOCATION" withString:newLocation];
}

@end
